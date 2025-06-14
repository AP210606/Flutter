// book_event.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetBooksEvent extends BookEvent {}

class CreateBookEvent extends BookEvent {
  final Book book;
  const CreateBookEvent(this.book);

  @override
  List<Object> get props => [book];
}

class UpdateBookEvent extends BookEvent {
  final Book book;
  const UpdateBookEvent(this.book);

  @override
  List<Object> get props => [book];
}

class DeleteBookEvent extends BookEvent {
  final String id;
  const DeleteBookEvent(this.id);

  @override
  List<Object> get props => [id];
}