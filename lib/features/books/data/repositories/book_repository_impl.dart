// book_repository_impl.dart
import 'package:dartz/dartz.dart'; // Or either_dart
import 'package:crud_app_bloc_dio/core/error/failures.dart';
import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_datasource.dart';
import '../models/book_model.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Book>>> getBooks() async {
    try {
      final remoteBooks = await remoteDataSource.getBooks();
      return Right(remoteBooks);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Book>> createBook(Book book) async {
    try {
      final bookModel = BookModel.fromEntity(book);
      final createdBook = await remoteDataSource.createBook(bookModel);
      return Right(createdBook);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Book>> updateBook(Book book) async {
    try {
      final bookModel = BookModel.fromEntity(book);
      final updatedBook = await remoteDataSource.updateBook(bookModel);
      return Right(updatedBook);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBook(String id) async {
    try {
      await remoteDataSource.deleteBook(id);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}