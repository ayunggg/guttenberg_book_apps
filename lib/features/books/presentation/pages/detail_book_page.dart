import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:guttenberg_book_apps/config/injection.dart";
import "package:guttenberg_book_apps/features/books/data/models/book_model.dart";
import "package:guttenberg_book_apps/features/books/presentation/controller/book_controller.dart";
import "package:guttenberg_book_apps/features/books/presentation/widgets/loading.dart";
import "package:guttenberg_book_apps/shared/theme.dart";

class DetailBookPage extends StatelessWidget {
  final int bookId;
  const DetailBookPage({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    final BookController bookController =
        Get.put(serviceLocator<BookController>());
    bookController.getDetailBook(bookId);

    var storage = GetStorage();
    if (bookController.listBookLiked.isEmpty) {
      if (storage.read('listBookLiked') != null) {
        final String decodeString = storage.read('listBookLiked');

        final List<BookModel> list = BookModel.decode(decodeString);

        if (list.isNotEmpty) {
          bookController.listBookLiked.value = list;
        }
      }
    }

    return Scaffold(
      body: Obx(
        () => bookController.isLoading.value == false
            ? ListView(
                children: [
                  coverImageSection(bookController),
                  const SizedBox(height: 30),
                  bookShelves(bookController),
                  const SizedBox(height: 10),
                  languages(bookController),
                  const SizedBox(height: 10),
                  subjects(bookController),
                  const SizedBox(
                    height: 30,
                  ),
                  likeDislikeButtonSection(bookController),
                  const SizedBox(height: 30)
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }

  Padding likeDislikeButtonSection(BookController bookController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              bookController.dislikeBook(bookController.bookModel.value);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: blackColor,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Obx(
                  () => Image.asset(
                    'assets/dislike.png',
                    width: 30,
                    height: 30,
                    color: bookController.isDislike.value
                        ? Colors.red
                        : blackColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Obx(
              () => bookController.isLiked.value == true
                  ? GestureDetector(
                      onTap: () {
                        bookController.removeBookFromFavorit(
                            bookController.bookModel.value);
                      },
                      child: Container(
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            "Remove From Favorie",
                            style: boldInter.copyWith(
                              fontSize: 20,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        bookController.likeBook(bookController.bookModel.value);
                      },
                      child: Container(
                        width: Get.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Text(
                            "Add To Favorite",
                            style: boldInter.copyWith(
                              fontSize: 20,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Padding bookShelves(BookController bookController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bookshelves",
            style: bold.copyWith(fontSize: 20, color: primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bookController.bookModel.value.bookshelves!.map((e) {
              return Text(
                e,
                style: regular.copyWith(
                  fontSize: 14,
                  color: blackColor,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Padding languages(BookController bookController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Languages",
            style: bold.copyWith(fontSize: 20, color: primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: bookController.bookModel.value.languages!.map((e) {
              return Text(
                e,
                style: regular.copyWith(
                  fontSize: 14,
                  color: blackColor,
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Padding subjects(BookController bookController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subjects",
            style: bold.copyWith(fontSize: 20, color: primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bookController.bookModel.value.subjects!.map((e) {
              return Text(
                e,
                style: regular.copyWith(
                  fontSize: 14,
                  color: blackColor,
                ),
                maxLines: 5,
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  SizedBox coverImageSection(BookController bookController) {
    return SizedBox(
      width: Get.width,
      height: 500,
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              child: Image.network(
                bookController.bookModel.value.formatModel!.imageJpeg!,
                width: Get.width,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 500,
            width: Get.width,
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(0.8),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: blackColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(3, 4), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  bookController.bookModel.value.formatModel!.imageJpeg!,
                  width: 150,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: blackColor,
                          )),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Detail Book",
                    style: bold.copyWith(
                      fontSize: 20,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width * 0.8,
              height: 100,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: blackColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(
                      0,
                      2,
                    ), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * 0.7,
                        child: Text(
                          bookController.bookModel.value.title!,
                          style: bold.copyWith(
                            fontSize: 14,
                            color: blackColor,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        children:
                            bookController.bookModel.value.authors!.map((e) {
                          return Text(
                            e.name!,
                            style: regular.copyWith(
                              fontSize: 12,
                              color: blackColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
