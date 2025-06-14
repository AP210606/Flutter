// book.dart
import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final List<String> authors;
  final String? coverImageUrl;

  const Book({
    required this.id,
    required this.title,
    required this.authors,
    this.coverImageUrl,
  });

  @override
  List<Object?> get props => [id, title, authors, coverImageUrl];
}