import 'package:dio/dio.dart';
import '../models/book_model.dart';

// Add this if you don't already have ServerException defined elsewhere
class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks();
  Future<BookModel> createBook(BookModel book);
  Future<BookModel> updateBook(BookModel book);
  Future<void> deleteBook(String id);
}


class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio; // Inject Dio client

  BookRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await dio.get('http://readbuddy-server.onrender.com/api/books');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to fetch books: ${response.statusCode}');
    }
  }

  @override
  Future<BookModel> createBook(BookModel book) async {
    final response = await dio.post(
      'http://readbuddy-server.onrender.com/api/books',
      data: book.toJson(),
    );
    if (response.statusCode == 201) {
      return BookModel.fromJson(response.data);
    } else {
      throw ServerException('Failed to create book: ${response.statusCode}');
    }
  }

  @override
  Future<BookModel> updateBook(BookModel book) async {
    final response = await dio.put(
      'http://readbuddy-server.onrender.com/api/books/${book.id}',
      data: book.toJson(),
    );
    if (response.statusCode == 200) {
      return BookModel.fromJson(response.data);
    } else {
      throw ServerException('Failed to update book: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteBook(String id) async {
    final response = await dio.delete('http://readbuddy-server.onrender.com/api/books/$id');
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw ServerException('Failed to delete book: ${response.statusCode}');
    }
  }
}