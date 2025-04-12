import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/book_provider.dart';
import '../widgets/input.dart';

class ListBook extends StatelessWidget {
  const ListBook({super.key});

  void _onAddPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InputBook(title: "Add", isEditMode: false),
      ),
    ).then((_) => context.read<BookProvider>().fetchBook());
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!bookProvider.hasData && !bookProvider.isLoading) {
        bookProvider.fetchBook();
      }
    });

    Widget content =
        bookProvider.isLoading
            ? const CircularProgressIndicator()
            : bookProvider.hasData
            ? bookProvider.bookState!.data!.isEmpty
                ? const Text('No books available')
                : ListView.builder(
                  itemCount: bookProvider.bookState!.data!.length,
                  itemBuilder: (context, index) {
                    final book = bookProvider.bookState!.data![index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(
                        "Author: ${book.author} - Publisher: ${book.publisher} - ${book.year}",
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => bookProvider.deleteBook(book.id),
                      ),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => InputBook(
                                    title: "Edit",
                                    book: book,
                                    isEditMode: true,
                                  ),
                            ),
                          ),
                    );
                  },
                )
            : const Text('');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: content),
    );
  }
}
