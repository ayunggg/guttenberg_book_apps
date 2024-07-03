import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guttenberg_book_apps/config/injection.dart';
import 'package:guttenberg_book_apps/features/books/data/models/book_model.dart';
import 'package:guttenberg_book_apps/features/books/presentation/controller/book_controller.dart';
import 'package:guttenberg_book_apps/features/books/presentation/pages/detail_book_page.dart';
import 'package:guttenberg_book_apps/shared/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BookController bookController =
        Get.put(serviceLocator<BookController>());

    var storage = GetStorage();
    if (storage.read('listBookLiked') != null) {
      final String decodeString = storage.read('listBookLiked');

      final List<BookModel> list = BookModel.decode(decodeString);

      if (list.isNotEmpty) {
        bookController.listBookLiked.value = list;
        print(bookController.listBookLiked.length);
      }
      // if (listBook.isNotEmpty) {
      //   bookController.listBookLiked.value = listBook;
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const SizedBox(height: 50),
        Text(
          "Favorite Screen",
          style: bold.copyWith(
            fontSize: 20,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          "All The Book's You Liked",
          style: regular.copyWith(
            fontSize: 12,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => bookController.listBookLiked.isNotEmpty
              ? Column(
                  children: bookController.listBookLiked.map((book) {
                    return CardFavoriteBook(
                      bookController: bookController,
                      bookModel: book,
                    );
                  }).toList(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Image.asset(
                      'assets/empty_book.png',
                      width: Get.width,
                      height: 350,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "You don't have \nfavorite book yet :(",
                      style: bold.copyWith(
                        fontSize: 24,
                        color: blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Let's find a book",
                      style: regular.copyWith(
                        fontSize: 16,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}

class CardFavoriteBook extends StatelessWidget {
  const CardFavoriteBook({
    super.key,
    required this.bookController,
    required this.bookModel,
  });

  final BookController bookController;
  final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(DetailBookPage(bookId: bookModel.id!)),
      child: Container(
        width: Get.width,
        height: 100,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: blackColor.withOpacity(0.15),
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  bookModel.formatModel!.imageJpeg != null
                      ? Image.network(
                          bookModel.formatModel!.imageJpeg!,
                          width: 75,
                          height: 75,
                        )
                      : const SizedBox(
                          width: 50,
                          child: Center(
                            child: Text("NO IMAGE"),
                          ),
                        ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          bookModel.title!,
                          style: medium.copyWith(
                            fontSize: 16,
                            color: blackColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                        children: bookModel.authorsModel!.map((e) {
                          return SizedBox(
                            width: Get.width * 0.5,
                            child: Text(
                              e.name!,
                              style: regular.copyWith(
                                fontSize: 12,
                                color: blackColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          "Download Count : ${bookModel.downloadCount}",
                          style: regular.copyWith(
                            fontSize: 12,
                            color: blackColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                bookController.removeBookFromFavorit(bookModel);
              },
              child: const Icon(
                Icons.remove_circle_outline_outlined,
                color: Colors.redAccent,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
