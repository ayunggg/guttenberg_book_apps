import 'dart:convert';

import 'package:guttenberg_book_apps/core/error/exception.dart';
import 'package:guttenberg_book_apps/features/books/data/models/book_model.dart';
import 'package:http/http.dart' as http;

abstract class DataBooksRemoteDataSource {
  Future<List<BookModel>> getAllBooks({int page = 1});
  Future<List<BookModel>> searchBook(String query);
  Future<BookModel> getDetailBook(int id);
}

class DataBooksRemoteDataSourceImpl extends DataBooksRemoteDataSource {
  @override
  Future<List<BookModel>> getAllBooks({int page = 1}) async {
    try {
      var response =
          await http.get(Uri.parse("https://gutendex.com/books/?page=$page"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["results"];
        return data.map((books) => BookModel.fromJson(books)).toList();
      } else if (response.statusCode == 404) {
        var message = jsonDecode(response.body)['detail'];
        throw message;
      } else {
        throw Future.error(
          ServerException(
            message: "Something Went Wrong [${response.statusCode}]",
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BookModel> getDetailBook(int id) async {
    try {
      var response =
          await http.get(Uri.parse("https://gutendex.com/books/$id"));

      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return BookModel.fromJson(data);
      } else if (response.statusCode == 404) {
        return Future.error(
          GeneralException(
            message: jsonDecode(response.body)['detail'],
          ),
        );
      } else {
        return Future.error(
          ServerException(
              message: "Something Went Wrong [${response.statusCode}]"),
        );
      }
    } catch (e) {
      return Future.error(
          const GeneralException(message: "Cannot get data user by id"));
    }
  }

  @override
  Future<List<BookModel>> searchBook(String query) async {
    try {
      var response = await http
          .get(Uri.parse("https://gutendex.com/books/?search=$query"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["results"];
        return data.map((books) => BookModel.fromJson(books)).toList();
      } else if (response.statusCode == 404) {
        var message = jsonDecode(response.body)['detail'];
        throw message;
      } else {
        throw Future.error(
          ServerException(
            message: "Something Went Wrong [${response.statusCode}]",
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
