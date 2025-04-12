import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/book.dart';
import '../provider/book_provider.dart';

class InputBook extends StatefulWidget {
  const InputBook({
    super.key,
    required this.title,
    this.book,
    this.isEditMode = false,
  });

  final String title;
  final Book? book;
  final bool isEditMode;

  @override
  State<InputBook> createState() => _InputBookState();
}

class _InputBookState extends State<InputBook> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController,
      _authorController,
      _publisherController,
      _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title);
    _authorController = TextEditingController(text: widget.book?.author);
    _publisherController = TextEditingController(text: widget.book?.publisher);
    _yearController = TextEditingController(text: widget.book?.year.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final author = _authorController.text;
      final publisher = _publisherController.text;
      final year = int.tryParse(_yearController.text) ?? 0;
      final bookProvider = Provider.of<BookProvider>(context, listen: false);

      if (widget.isEditMode) {
        bookProvider.updateBook(
          Book(
            id: widget.book!.id,
            title: title,
            author: author,
            publisher: publisher,
            year: year,
          ),
        );
      } else {
        bookProvider.addBook(title, author, publisher, year);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title} Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                validator:
                    (value) =>
                        value?.isEmpty ?? true ? 'Title cannot be empty' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Author'),
                controller: _authorController,
                validator:
                    (value) =>
                        value?.isEmpty ?? true
                            ? 'Author cannot be empty'
                            : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Publisher'),
                controller: _publisherController,
                validator:
                    (value) =>
                        value?.isEmpty ?? true
                            ? 'Publisher cannot be empty'
                            : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year'),
                controller: _yearController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Year cannot be empty';
                  final year = int.tryParse(value!);
                  return year == null || year <= 0 || year > 2025
                      ? 'Year must be between 1 and 2025'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
