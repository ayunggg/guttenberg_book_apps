import 'package:dartz/dartz.dart';
import 'package:guttenberg_book_apps/core/error/failure.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';
import 'package:guttenberg_book_apps/features/books/domain/repositories/book_repository.dart';

class SearchBook {
  final BookRepository bookRepository;

  const SearchBook({required this.bookRepository});

  Future<Either<Failure, List<Book>>> call({required String query}) async {
    return await bookRepository.searchBook(query);
  }
}