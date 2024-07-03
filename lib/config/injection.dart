import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:guttenberg_book_apps/features/books/data/datasources/data_books_local_data_source.dart';
import 'package:guttenberg_book_apps/features/books/data/datasources/data_books_remote_data_source.dart';
import 'package:guttenberg_book_apps/features/books/data/repositories/book_repository_implementation.dart';
import 'package:guttenberg_book_apps/features/books/domain/repositories/book_repository.dart';
import 'package:guttenberg_book_apps/features/books/domain/usecases/get_all_data_book.dart';
import 'package:guttenberg_book_apps/features/books/domain/usecases/get_detail_data_book.dart';
import 'package:guttenberg_book_apps/features/books/domain/usecases/search_book.dart';
import 'package:guttenberg_book_apps/features/books/presentation/controller/book_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencyInjection() async {
  serviceLocator.registerFactory(() => BookController(
        getAllDataBook: serviceLocator.call(),
        getDetailDataBook: serviceLocator.call(),
        searchBook: serviceLocator.call(),
      ));

  serviceLocator.registerLazySingleton(
    () => GetAllDataBook(
      bookRepository: serviceLocator.call(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetDetailDataBook(
      bookRepository: serviceLocator.call(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => SearchBook(
      bookRepository: serviceLocator.call(),
    ),
  );

  serviceLocator.registerLazySingleton<BookRepository>(
    () => BookRepositoryImplementation(
      dataBooksLocalDataSource: serviceLocator.call(),
      dataBooksRemoteDataSource: serviceLocator.call(),
      hive: serviceLocator.call(),
    ),
  );

  serviceLocator.registerLazySingleton<DataBooksLocalDataSource>(
    () => DataBooksLocalDataSourceImpl(hive: serviceLocator.call()),
  );
  serviceLocator.registerLazySingleton<DataBooksRemoteDataSource>(
    () => DataBooksRemoteDataSourceImpl(),
  );

  serviceLocator.registerLazySingleton(
    () => Connectivity(),
  );

  // Initialize Hive
  await Hive.initFlutter();

  // Register HiveInterface
  serviceLocator.registerSingleton<HiveInterface>(Hive);
}
