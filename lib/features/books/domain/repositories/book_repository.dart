// book_repository.dart
import 'package:dartz/dartz.dart'; // Or either_dart
import 'package:crud_app_bloc_dio/core/error/failures.dart';
import '../entities/book.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getBooks();
  Future<Either<Failure, Book>> createBook(Book book);
  Future<Either<Failure, Book>> updateBook(Book book);
  Future<Either<Failure, void>> deleteBook(String id);
}