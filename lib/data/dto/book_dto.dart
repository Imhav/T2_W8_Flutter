import '../../model/book.dart';

class BookDto {
  static Book fromJson(String id, Map<String, dynamic> json) {
    return Book(
      id: id,
      title: json['title'],
      author: json['author'],
      publisher: json['publisher'],
      year: json['year'],
    );
  }

  static Map<String, dynamic> toJson(Book book) {
    return {
      'title': book.title,
      'author': book.author,
      'publisher': book.publisher,
      'year': book.year,
    };
  }
}