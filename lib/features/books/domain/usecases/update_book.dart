// update_book.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import 'package:crud_app_bloc_dio/core/usecases/usecase.dart';
import '../entities/book.dart';
import '../repositories/book_repository.dart';

class UpdateBook implements UseCase<Book, UpdateBookParams> {
  final BookRepository repository;

  UpdateBook(this.repository);

  @override
  Future<Either<Failure, Book>> call(UpdateBookParams params) async {
    return await repository.updateBook(params.book);
  }
}

class UpdateBookParams extends Equatable {
  final Book book;

  const UpdateBookParams({required this.book});

  @override
  List<Object?> get props => [book];
}