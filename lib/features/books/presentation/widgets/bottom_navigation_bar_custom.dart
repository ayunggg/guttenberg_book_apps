import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guttenberg_book_apps/features/books/presentation/controller/book_controller.dart';
import 'package:guttenberg_book_apps/shared/theme.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  final BookController bookController;
  const BottomNavigationBarCustom({
    super.key,
    required this.bookController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                bookController.indexPage.value = 0;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bookController.indexPage.value == 0
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 4),
                  Image.asset(
                    'assets/ic_home.png',
                    width: 24,
                    height: 24,
                    color: bookController.indexPage.value == 0
                        ? primaryColor
                        : grayColor,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                bookController.indexPage.value = 1;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bookController.indexPage.value == 1
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 4),
                  Image.asset(
                    'assets/ic_like.png',
                    width: 24,
                    height: 24,
                    color: bookController.indexPage.value == 1
                        ? primaryColor
                        : grayColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
