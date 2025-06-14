// main.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart'; // UNCOMMENT THIS LINE

import 'features/books/data/datasources/book_remote_datasource.dart';
import 'features/books/data/repositories/book_repository_impl.dart';
import 'features/books/domain/repositories/book_repository.dart';
import 'features/books/domain/usecases/create_book.dart';
import 'features/books/domain/usecases/delete_book.dart';
import 'features/books/domain/usecases/get_books.dart';
import 'features/books/domain/usecases/update_book.dart';
import 'features/books/presentation/bloc/book_bloc.dart';
import 'features/books/presentation/pages/book_list_page.dart';

final getIt = GetIt.instance;

void main() {
  setupLocator();
  runApp(const MyApp());
}

void setupLocator() {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register Data Sources
  getIt.registerLazySingleton<BookRemoteDataSource>(
    () => BookRemoteDataSourceImpl(getIt()),
  );

  // Register Repositories
  getIt.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(getIt()),
  );

  // Register Use Cases
  getIt.registerLazySingleton<GetBooks>(() => GetBooks(getIt()));
  getIt.registerLazySingleton<CreateBook>(() => CreateBook(getIt()));
  getIt.registerLazySingleton<UpdateBook>(() => UpdateBook(getIt()));
  getIt.registerLazySingleton<DeleteBook>(() => DeleteBook(getIt()));

  // Register BLoC
  getIt.registerFactory<BookBloc>(
    () => BookBloc(
      getBooks: getIt(),
      createBook: getIt(),
      updateBook: getIt(),
      deleteBook: getIt(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadBuddy CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => getIt<BookBloc>(),
        child: const BookListPage(),
      ),
    );
  }
}