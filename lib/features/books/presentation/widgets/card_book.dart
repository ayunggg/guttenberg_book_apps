import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guttenberg_book_apps/features/books/data/models/book_model.dart';
import 'package:guttenberg_book_apps/shared/theme.dart';

class CardBook extends StatelessWidget {
  const CardBook({super.key, required this.bookModel, required this.index});

  final BookModel bookModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          bookModel.formatModel!.imageJpeg != null
              ? Image.network(bookModel.formatModel!.imageJpeg!)
              : const Center(
                  child: Text(
                    "NO IMAGE",
                  ),
                ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookModel.title!,
                  style: medium.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                Column(
                  children: bookModel.authorsModel!.map((e) {
                    return Text(
                      e.name!,
                      style: regular.copyWith(fontSize: 12),
                    );
                  }).toList(),
                ),
                Text(
                  "Download Count : ${bookModel.downloadCount}",
                  style: regular.copyWith(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
