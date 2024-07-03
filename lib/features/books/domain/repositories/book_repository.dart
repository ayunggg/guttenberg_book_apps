import 'package:dartz/dartz.dart';
import 'package:guttenberg_book_apps/core/error/failure.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getAllBooks(int page);
  Future<Either<Failure, Book>> getDetailBook(int id);
  Future<Either<Failure, List<Book>>> searchBook(String query);
}
