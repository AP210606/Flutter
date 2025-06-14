// delete_book.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import 'package:crud_app_bloc_dio/core/usecases/usecase.dart';
import '../repositories/book_repository.dart';

class DeleteBook implements UseCase<void, DeleteBookParams> {
  final BookRepository repository;

  DeleteBook(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteBookParams params) async {
    return await repository.deleteBook(params.id);
  }
}

class DeleteBookParams extends Equatable {
  final String id;

  const DeleteBookParams({required this.id});

  @override
  List<Object?> get props => [id];
}