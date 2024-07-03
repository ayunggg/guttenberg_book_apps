import 'package:dartz/dartz.dart';
import 'package:guttenberg_book_apps/core/error/failure.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';
import 'package:guttenberg_book_apps/features/books/domain/repositories/book_repository.dart';

class GetAllDataBook {
  final BookRepository bookRepository;

  const GetAllDataBook({required this.bookRepository});

  Future<Either<Failure, List<Book>>> call({int page = 1}) async {
    return await bookRepository.getAllBooks(page);
  }
}
