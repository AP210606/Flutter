// // Add other specific failures as needed, e.g.:
// class NetworkFailure extends Failure {
//   const NetworkFailure([super.message = 'No Internet Connection']);
// }

// class InvalidInputFailure extends Failure {
//   const InvalidInputFailure([super.message = 'Invalid Input']);
// }// book_repository_impl.dart
// import 'package:dartz/dartz.dart'; // Or either_dart
// import 'package:crud_app_bloc_dio/core/error/failures.dart';
// import 'package:crud_app_bloc_dio/core/error/exceptions.dart'; // <--- ADD THIS LINE
// import '../../domain/entities/book.dart';
// import '../../domain/repositories/book_repository.dart';
// import '../datasources/book_remote_datasource.dart';
// import '../models/book_model.dart';

// class BookRepositoryImpl implements BookRepository {
//   final BookRemoteDataSource remoteDataSource;

//   BookRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<Either<Failure, List<Book>>> getBooks() async {
//     try {
//       final remoteBooks = await remoteDataSource.getBooks();
//       return Right(remoteBooks);
//     } on ServerException catch (e) { // ServerException should now be recognized
//       return Left(ServerFailure(e.message)); // ServerFailure should now be recognized
//     } catch (e) {
//       return Left(UnknownFailure(e.toString())); // UnknownFailure should now be recognized
//     }
//   }

//   @override
//   Future<Either<Failure, Book>> createBook(Book book) async {
//     try {
//       final bookModel = BookModel.fromEntity(book);
//       final createdBook = await remoteDataSource.createBook(bookModel);
//       return Right(createdBook);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     } catch (e) {
//       return Left(UnknownFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, Book>> updateBook(Book book) async {
//     try {
//       final bookModel = BookModel.fromEntity(book);
//       final updatedBook = await remoteDataSource.updateBook(bookModel);
//       return Right(updatedBook);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     } catch (e) {
//       return Left(UnknownFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteBook(String id) async {
//     try {
//       await remoteDataSource.deleteBook(id);
//       return Right(null);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     } catch (e) {
//       return Left(UnknownFailure(e.toString()));
//     }
//   }
// }