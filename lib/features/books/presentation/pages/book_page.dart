// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:guttenberg_book_apps/config/injection.dart';
import 'package:guttenberg_book_apps/features/books/presentation/controller/book_controller.dart';
import 'package:guttenberg_book_apps/features/books/presentation/pages/detail_book_page.dart';
import 'package:guttenberg_book_apps/features/books/presentation/pages/favorite_screen.dart';
import 'package:guttenberg_book_apps/features/books/presentation/widgets/bottom_navigation_bar_custom.dart';
import 'package:guttenberg_book_apps/features/books/presentation/widgets/card_book.dart';
import 'package:guttenberg_book_apps/features/books/presentation/widgets/loading.dart';
import 'package:guttenberg_book_apps/shared/theme.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookController bookController = serviceLocator<BookController>();
    bookController.fetchBook();

    ScrollController scrollController = ScrollController();

    onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && bookController.hasMore.value) {
        bookController.loadMoreBook();
      }
    }

    scrollController.addListener(onScroll);

    print(bookController.listBookLiked.length);
    return Scaffold(
      floatingActionButton: Obx(
        () => bookController.isLoading.value == false
            ? BottomNavigationBarCustom(
                bookController: bookController,
              )
            : const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(
        () => bookController.isLoading.value == false
            ? bookController.indexPage.value == 0
                ? screenHome(bookController, scrollController)
                : const FavoriteScreen()
            : const LoadingWidget(),
      ),
    );
  }

  ListView screenHome(
      BookController bookController, ScrollController scrollController) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      children: [
        Text(
          "Gutenberg Books",
          style: medium.copyWith(
            fontSize: 18,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 18),
        searchField(bookController),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => SizedBox(
            height: Get.height,
            child: MasonryGridView.builder(
              controller: scrollController,
              itemCount: bookController.listBookSearched.isEmpty
                  ? bookController.listBook.length
                  : bookController.listBookSearched.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Obx(
                  () => bookController.listBookSearched.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            Get.to(
                              DetailBookPage(
                                bookId: bookController.listBook[index].id!,
                              ),
                            );
                          },
                          child: CardBook(
                            bookModel: bookController.listBook[index],
                            index: index,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.to(
                              DetailBookPage(
                                bookId:
                                    bookController.listBookSearched[index].id!,
                              ),
                            );
                          },
                          child: CardBook(
                            bookModel: bookController.listBookSearched[index],
                            index: index,
                          ),
                        ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 30),
        Obx(
          () => bookController.isLoadMoreBook.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox(),
        ),
        Obx(() => bookController.isLoadMoreBook.value
            ? const SizedBox(height: 100)
            : const SizedBox())
      ],
    );
  }

  TextFormField searchField(BookController bookController) {
    return TextFormField(
      controller: bookController.searchController,
      onChanged: (v) {
        if (v.isEmpty) {
          bookController.listBookSearched.isNotEmpty
              ? bookController.listBookSearched.clear()
              : null;
          bookController.hasMore.value = true;
        }
      },
      onEditingComplete: () {
        if (bookController.searchController.text.isNotEmpty) {
          bookController.searchBookMethod();
          bookController.hasMore.value = false;
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        fillColor: primaryColor.withOpacity(0.15),
        filled: true,
        hintText: "Search for books",
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 2,
        ),
      ),
    );
  }
}
