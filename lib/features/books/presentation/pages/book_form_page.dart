// book_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book.dart';
import '../bloc/book_bloc.dart';
import '../bloc/book_event.dart';
// import '../bloc/book_state.dart';

class BookFormPage extends StatefulWidget {
  final Book? book; // Null for add, non-null for edit
  const BookFormPage({Key? key, this.book}) : super(key: key);

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorsController;
  late TextEditingController _coverImageUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorsController = TextEditingController(text: widget.book?.authors.join(', ') ?? '');
    _coverImageUrlController = TextEditingController(text: widget.book?.coverImageUrl ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorsController.dispose();
    _coverImageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final authors = _authorsController.text.split(',').map((e) => e.trim()).toList();
      final coverImageUrl = _coverImageUrlController.text.trim();

      if (widget.book == null) {
        // Create new book (API will generate ID)
        final newBook = Book(
          id: '', // ID will be assigned by the server
          title: title,
          authors: authors,
          coverImageUrl: coverImageUrl.isEmpty ? null : coverImageUrl,
        );
        context.read<BookBloc>().add(CreateBookEvent(newBook));
      } else {
        // Update existing book
        final updatedBook = Book(
          id: widget.book!.id,
          title: title,
          authors: authors,
          coverImageUrl: coverImageUrl.isEmpty ? null : coverImageUrl,
        );
        context.read<BookBloc>().add(UpdateBookEvent(updatedBook));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add New Book' : 'Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorsController,
                decoration: const InputDecoration(
                  labelText: 'Authors (comma-separated)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one author';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _coverImageUrlController,
                decoration: const InputDecoration(labelText: 'Cover Image URL (Optional)'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.book == null ? 'Add Book' : 'Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}