import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:book_store/core/constants/api_constants.dart';
import 'package:book_store/core/exceptions/exceptions.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:http/http.dart' as http;

class BooksRemoteDataSource {
  Future<List<Book>> fetchBooks({
    required String query,
    required int startIndex,
    required int pageSize,
  }) async {
    final uri = Uri.https(ApiConstants.host, '${ApiConstants.basePath}/${ApiConstants.bookList}', {
      "q": query,
      "startIndex": startIndex.toString(),
      "maxResults": pageSize.toString(),
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final items = decoded["items"] as List? ?? [];
        return items.map((e) => Book.fromJson(e)).toList();
      } else if (response.statusCode >= 500) {
        throw ServerException(
          'Server returned error ${response.statusCode}',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode >= 400) {
        throw ServerException(
          'Client error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          'Unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException catch (e) {
      throw NetworkException('No internet connection: ${e.message}');
    } on FormatException catch (e) {
      throw ServerException('Invalid response format: ${e.message}');
    } on TimeoutException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error: ${e.message}');
    } catch (e) {
      throw NetworkException('Unexpected error: ${e.toString()}');
    }
  }
}
