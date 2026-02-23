import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_database/firebase_database.dart';

abstract class IRemoteStorageDataSource {
  Future<String?> uploadToImgBB(File image);
  Future<void> saveUrlToFirestore(String url);
  Stream<List<String>> getUrlsStreamFromFirestore();
}

class RemoteStorageDatasource implements IRemoteStorageDataSource {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  static const String imgbbApiKey = '388d4a2ee7b514bec6a93cb06d2ec3ac';
  static const String imgbbBaseUrl = "https://api.imgbb.com/1/upload";
  
  @override
  Stream<List<String>> getUrlsStreamFromFirestore() {
    return database
        .ref('uploaded_images')
        .orderByChild('createdAt')
        .onValue
        .map((event) {
      if (event.snapshot.value == null) return [];
      
      final Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
      final List<String> urls = data.values
          .map((value) => (value as Map)['url'] as String)
          .toList();
          
      return urls;
    });
  }

  @override
  Future<void> saveUrlToFirestore(String url) async {
    try {
      await database.ref('uploaded_images').push().set({
        'url': url,
        'createdAt': ServerValue.timestamp,
      }).timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception('Failed to save URL to Realtime Database: $e');
    }
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
