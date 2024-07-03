import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guttenberg_book_apps/core/error/failure.dart';
import 'package:guttenberg_book_apps/features/books/data/datasources/data_books_local_data_source.dart';
import 'package:guttenberg_book_apps/features/books/data/datasources/data_books_remote_data_source.dart';
import 'package:guttenberg_book_apps/features/books/data/models/book_model.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';
import 'package:guttenberg_book_apps/features/books/domain/repositories/book_repository.dart';
import 'package:hive/hive.dart';

class BookRepositoryImplementation extends BookRepository {
  final DataBooksLocalDataSource dataBooksLocalDataSource;
  final DataBooksRemoteDataSource dataBooksRemoteDataSource;
  final HiveInterface hive;

  BookRepositoryImplementation({
    required this.dataBooksLocalDataSource,
    required this.dataBooksRemoteDataSource,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<BookModel>>> getAllBooks(int page) async {
    try {
      var storage = GetStorage();
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        print("JALAN OFFLINE");
        List<BookModel> result =
            await dataBooksLocalDataSource.getAllBooks(page: page);

        return Right(result);
      } else {
        print("JALAN ONLINE");
        var result = await dataBooksRemoteDataSource.getAllBooks(
          page: page,
        );

        storage.write("getAllBooks", result);

        return Right(result);
      }
    } catch (e) {
      return Left(GeneralFailure(message: "Cannot get data ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Book>> getDetailBook(int id) async {
    try {
      var storage = GetStorage();
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        BookModel result = await dataBooksLocalDataSource.getDetailBook(id);

        return Right(result);
      } else {
        var result = await dataBooksRemoteDataSource.getDetailBook(id);

        storage.write("getDetailBook", result);

        return Right(result);
      }
    } catch (e) {
      print(e.toString());
      return Left(GeneralFailure(message: "Cannot get data ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, List<Book>>> searchBook(String query) async {
    try {
      var storage = GetStorage();
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        print("JALAN OFFLINE");
        List<BookModel> result =
            await dataBooksLocalDataSource.searchBook(query);

        return Right(result);
      } else {
        print("JALAN ONLINE");
        var result = await dataBooksRemoteDataSource.searchBook(query);

        storage.write("searchBook", result);

        return Right(result);
      }
    } catch (e) {
      return Left(GeneralFailure(message: "Cannot get data ${e.toString()}"));
    }
  }
}
