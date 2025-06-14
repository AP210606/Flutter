// book_model.dart
import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required String id,
    required String title,
    required List<String> authors,
    String? coverImageUrl,
  }) : super(
          id: id,
          title: title,
          authors: authors,
          coverImageUrl: coverImageUrl,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      authors: List<String>.from(json['authors'] as List),
      coverImageUrl: json['coverImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'authors': authors,
      'coverImageUrl': coverImageUrl,
    };
  }

  // Helper method for creating from entity if needed for sending data
  factory BookModel.fromEntity(Book entity) {
    return BookModel(
      id: entity.id,
      title: entity.title,
      authors: entity.authors,
      coverImageUrl: entity.coverImageUrl,
    );
  }
}