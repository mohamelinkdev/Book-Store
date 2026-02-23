import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IRemoteStorageDataSource {
  Future<String?> uploadToImgBB(File image);
  Future<void> saveUrlToFirestore(String url);
  Stream<List<String>> getUrlsStreamFromFirestore();
}

class RemoteStorageDatasource implements IRemoteStorageDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const String imgbbApiKey = '388d4a2ee7b514bec6a93cb06d2ec3ac';
  static const String imgbbBaseUrl = "https://api.imgbb.com/1/upload";
  @override
  Stream<List<String>> getUrlsStreamFromFirestore() {
    return firestore
        .collection('uploaded_images')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc['url'] as String).toList());
  }

  @override
  Future<void> saveUrlToFirestore(String url) async {
    await firestore.collection('uploaded_images').add({
      'url': url,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<String?> uploadToImgBB(File image) async {
    var request = http.MultipartRequest("POST", Uri.parse(imgbbBaseUrl));
    request.fields['key'] = imgbbApiKey;
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await http.Response.fromStream(response);
      return json.decode(responseData.body)['data']['url'];
    }
    return null;
  }
}
