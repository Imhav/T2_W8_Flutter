import '../../model/book.dart';

abstract class BookRepository {
  Future<Book> addBook({
    required String title,
    required String author,
    required String publisher,
    required int year,
  });
  Future<List<Book>> getBook();
  Future<String> deleteBook(String id);
  Future<Book> updateBook({
    required String id,
    required String title,
    required String author,
    required String publisher,
    required int year,
  });
}