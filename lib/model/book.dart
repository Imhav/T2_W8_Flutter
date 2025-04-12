class Book {
  final String id;
  final String title;
  final String author;
  final String publisher;
  final int year;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.year,
  });
  @override
  bool operator ==(Object other) {
    return other is Book && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
  @override
  String toString() {
    return 'Book(title: $id, author: $author, publisher: $publisher, year: $year)';
  }
}