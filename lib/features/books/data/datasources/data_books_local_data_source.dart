import 'package:get_storage/get_storage.dart';
import 'package:guttenberg_book_apps/features/books/data/models/book_model.dart';
import 'package:hive/hive.dart';

abstract class DataBooksLocalDataSource {
  Future<List<BookModel>> getAllBooks({int page = 1});
  Future<List<BookModel>> searchBook(String query);
  Future<BookModel> getDetailBook(int id);
}

class DataBooksLocalDataSourceImpl extends DataBooksLocalDataSource {
  final HiveInterface hive;
  DataBooksLocalDataSourceImpl({required this.hive});

  @override
  Future<List<BookModel>> getAllBooks({int page = 1}) async {
    var storage = GetStorage();
    return storage.read('getAllBook');
  }

  @override
  Future<BookModel> getDetailBook(int id) async {
    var storage = GetStorage();
    return storage.read('getDetailBook');
  }

  @override
  Future<List<BookModel>> searchBook(String query) async {
    var storage = GetStorage();
    return storage.read('searchBook');
  }
}
