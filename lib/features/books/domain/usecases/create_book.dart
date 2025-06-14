// create_book.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import 'package:crud_app_bloc_dio/core/usecases/usecase.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class CreateBook implements UseCase<Book, CreateBookParams> {
  final BookRepository repository;

  CreateBook(this.repository);

  @override
  Future<Either<Failure, Book>> call(CreateBookParams params) async {
    return await repository.createBook(params.book);
  }
}

class CreateBookParams extends Equatable {
  final Book book;

  const CreateBookParams({required this.book});

  @override
  List<Object?> get props => [book];
}