// Example: lib/features/books/domain/usecases/get_books.dart
import 'package:crud_app_bloc_dio/core/usecases/usecase.dart'; // <-- CORRECT IMPORT
import 'package:crud_app_bloc_dio/core/error/failures.dart'; // Also make sure failures are imported from core
import 'package:dartz/dartz.dart';
import '../entities/book.dart'; // Local entity import
import '../repositories/book_repository.dart'; // Local repository import

class GetBooks implements UseCase<List<Book>, NoParams> { // Use core UseCase and NoParams
  final BookRepository repository;

  GetBooks(this.repository);

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) async {
    return await repository.getBooks();
  }
}