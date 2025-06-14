// book_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';
import 'package:crud_app_bloc_dio/core/error/failures.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  const BookLoaded({this.books = const []});

  @override
  List<Object> get props => [books];
}

class BookError extends BookState {
  final String message;
  const BookError(this.message);

  @override
  List<Object> get props => [message];
}

class BookOperationSuccess extends BookState {
  final String message;
  const BookOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}