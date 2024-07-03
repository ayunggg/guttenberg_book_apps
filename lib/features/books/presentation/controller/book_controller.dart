import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guttenberg_book_apps/core/error/failure.dart';
import 'package:guttenberg_book_apps/features/books/data/models/book_model.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';
import 'package:guttenberg_book_apps/features/books/domain/usecases/get_all_data_book.dart';
import 'package:guttenberg_book_apps/features/books/domain/usecases/get_detail_data_book.dart';
import 'package:guttenberg_book_apps/features/books/domain/usecases/search_book.dart';
import 'package:guttenberg_book_apps/shared/theme.dart';

class BookController extends GetxController {
  final GetAllDataBook getAllDataBook;
  final SearchBook searchBook;
  final GetDetailDataBook getDetailDataBook;

  BookController({
    required this.getAllDataBook,
    required this.searchBook,
    required this.getDetailDataBook,
  });

  TextEditingController searchController = TextEditingController();

  RxList<BookModel> listBook = <BookModel>[].obs;
  RxList<BookModel> listBookLiked = <BookModel>[].obs;
  RxList<BookModel> listBookSearched = <BookModel>[].obs;
  Rx<BookModel> bookModel = const BookModel().obs;
  RxBool isLoading = false.obs;
  RxBool isLoadMoreBook = false.obs;
  RxBool isAdded = false.obs;
  RxBool hasMore = true.obs;
  RxBool isDislike = false.obs;
  RxBool isLiked = false.obs;
  RxInt page = 1.obs;
  RxInt indexPage = 0.obs;

  Future<void> fetchBook() async {
    isLoading.value = true;
    List<Book> list = [];
    try {
      Either<Failure, List<Book>> data = await getAllDataBook(page: page.value);
      data.fold(
          (message) => Get.snackbar(
                "Something Went Wrong",
                message.toString(),
              ), (book) {
        list.addAll(book);
        if (book.length < 32) {
          hasMore.value = false;
        }
      });

      for (var dataBook in list) {
        BookModel bookModel = dataBook as BookModel;
        listBook.add(bookModel);
      }
      page.value++;
      Future.delayed(
          const Duration(
            seconds: 2,
          ), () {
        isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar(
        "Something Went Wrong",
        e.toString(),
      );
    }
  }

  Future<void> getDetailBook(int id) async {
    try {
      isLoading.value = true;

      Either<Failure, Book> data = await getDetailDataBook(id: id);

      data.fold((message) {
        print("JALAN FOLD ERROR");
        Get.snackbar(
          "Something Went Wrong",
          message.toString(),
        );
      }, (book) {
        bookModel.value = book as BookModel;
        checkProductExist(bookModel.value);
      });

      print(bookModel.value.title);

      Future.delayed(
          const Duration(
            seconds: 2,
          ), () {
        isLoading.value = false;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadMoreBook() async {
    isLoadMoreBook.value = true;
    List<Book> list = [];
    try {
      Either<Failure, List<Book>> data = await getAllDataBook(page: page.value);
      Future.delayed(
          const Duration(
            seconds: 4,
          ),
          () {});

      data.fold(
          (message) => Get.snackbar(
                "Something Went Wrong",
                message.toString(),
              ), (book) {
        list.addAll(book);
        if (book.length < 32) {
          hasMore.value = false;
        }
      });

      for (var dataBook in list) {
        BookModel bookModel = dataBook as BookModel;
        listBook.add(bookModel);
      }
      page.value++;

      isLoadMoreBook.value = false;
    } catch (e) {
      Get.snackbar(
        "Something Went Wrong",
        e.toString(),
      );
    }
  }

  Future<void> searchBookMethod() async {
    try {
      isLoading.value = true;
      List<Book> list = [];
      listBookSearched.clear();
      Either<Failure, List<Book>> data =
          await searchBook(query: searchController.text);

      data.fold(
          (message) => Get.snackbar("Something Went Wrong", message.toString()),
          (book) {
        list.addAll(book);
      });

      for (var dataBook in list) {
        BookModel bookModel = dataBook as BookModel;
        listBookSearched.add(bookModel);
      }

      Future.delayed(
          const Duration(
            seconds: 2,
          ), () {
        isLoading.value = false;
      });
    } catch (e) {
      Get.snackbar(
        "SOMETHING WENT WRONG",
        e.toString(),
      );
    }
  }

  Future<void> dislikeBook(BookModel bookModel) async {
    try {
      if (isDislike.value) {
        isDislike.value = false;
      } else if (await checkProductExist(bookModel)) {
        isDislike.value = true;
        await removeBookFromFavorit(bookModel);
        Get.snackbar(
          "Oppppsss",
          "Why you don't like this book :(",
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
      } else {
        isDislike.value = true;
        Get.snackbar(
          "Oppppsss",
          "Why you don't like this book :(",
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> likeBook(BookModel bookModel) async {
    try {
      if (checkProductExist(bookModel) == false) {
        var storage = GetStorage();
        if (isDislike.value == true) {
          isDislike.value = false;
        }

        listBookLiked.add(bookModel);
        final String encodeData = BookModel.encode(listBookLiked);
        await storage.write('listBookLiked', encodeData);
        Get.snackbar(
          "Success Add To Favorite",
          "Book successfully added to favorites",
          backgroundColor: primaryColor,
          colorText: whiteColor,
        );
        checkProductExist(bookModel);
        print(listBookLiked.length);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeBookFromFavorit(BookModel bookModel) async {
    try {
      print("JALAN REMOVE BOOK");
      var storage = GetStorage();
      listBookLiked.removeWhere((book) => book.id == bookModel.id);
      final String encodeData = BookModel.encode(listBookLiked);
      await storage.write('listBookLiked', encodeData);
      checkProductExist(bookModel);
      print(listBookLiked.length);
    } catch (e) {
      rethrow;
    }
  }

  checkProductExist(BookModel bookModel) {
    var storage = GetStorage();
    if (storage.read('listBookLiked') != null) {
      final String decodeString = storage.read('listBookLiked');

      final List<BookModel> list = BookModel.decode(decodeString);

      if (list.indexWhere((element) => element.id! == bookModel.id) == -1) {
        isLiked.value = false;
        return false;
      } else {
        isLiked.value = true;
        return true;
      }
    } else {
      isLiked.value = false;
      return false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
