import 'package:dartz/dartz.dart';
import 'package:guttenberg_book_apps/core/error/failure.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';
import 'package:guttenberg_book_apps/features/books/domain/repositories/book_repository.dart';

class GetDetailDataBook {
  final BookRepository bookRepository;

  const GetDetailDataBook({required this.bookRepository});

  Future<Either<Failure, Book>> call({required int id}) async {
    return await bookRepository.getDetailBook(id);
  }
}
