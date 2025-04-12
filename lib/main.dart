import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w8/data/repository/book_firebase_reposity.dart';
import 'UI/provider/book_provider.dart';
import 'UI/screen/book_list_screen.dart';
import 'data/repository/book_repository.dart';

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) => ListBook();
}

void main() {
  final BookRepository bookRepository = BookFirebaseRepository(
    baseUrl:
        'https://havfirebase-default-rtdb.asia-southeast1.firebasedatabase.app/books/',
    bookCollection: 'books',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => BookProvider(bookRepository),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BookApp(),
      ),
    ),
  );
}
