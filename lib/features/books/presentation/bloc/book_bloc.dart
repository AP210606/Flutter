// book_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import 'package:crud_app_bloc_dio/core/usecases/usecase.dart';// import '../../domain/entities/book.dart';
import '../../domain/usecases/create_book.dart';
import '../../domain/usecases/delete_book.dart';
import '../../domain/usecases/get_books.dart';
import '../../domain/usecases/update_book.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBooks getBooks;
  final CreateBook createBook;
  final UpdateBook updateBook;
  final DeleteBook deleteBook;

  BookBloc({
    required this.getBooks,
    required this.createBook,
    required this.updateBook,
    required this.deleteBook,
  }) : super(BookInitial()) {
    on<GetBooksEvent>(_onGetBooks);
    on<CreateBookEvent>(_onCreateBook);
    on<UpdateBookEvent>(_onUpdateBook);
    on<DeleteBookEvent>(_onDeleteBook);
  }

  Future<void> _onGetBooks(GetBooksEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final result = await getBooks(NoParams());
    result.fold(
      (failure) => emit(BookError(_mapFailureToMessage(failure))),
      (books) => emit(BookLoaded(books: books)),
    );
  }

  Future<void> _onCreateBook(CreateBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final result = await createBook(CreateBookParams(book: event.book));
    result.fold(
      (failure) => emit(BookError(_mapFailureToMessage(failure))),
      (book) {
        // After successful creation, refetch books to update the list
        add(GetBooksEvent());
        emit(const BookOperationSuccess('Book created successfully!'));
      },
    );
  }

  Future<void> _onUpdateBook(UpdateBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final result = await updateBook(UpdateBookParams(book: event.book));
    result.fold(
      (failure) => emit(BookError(_mapFailureToMessage(failure))),
      (book) {
        // After successful update, refetch books to update the list
        add(GetBooksEvent());
        emit(const BookOperationSuccess('Book updated successfully!'));
      },
    );
  }

  Future<void> _onDeleteBook(DeleteBookEvent event, Emitter<BookState> emit) async {
    emit(BookLoading());
    final result = await deleteBook(DeleteBookParams(id: event.id));
    result.fold(
      (failure) => emit(BookError(_mapFailureToMessage(failure))),
      (_) {
        // After successful deletion, refetch books to update the list
        add(GetBooksEvent());
        emit(const BookOperationSuccess('Book deleted successfully!'));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else {
      return 'Unexpected error: ${failure.message}';
    }
  }
}