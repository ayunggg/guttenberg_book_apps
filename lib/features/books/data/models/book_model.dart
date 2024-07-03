import 'dart:convert';

import 'package:guttenberg_book_apps/features/books/data/models/authors_model.dart';
import 'package:guttenberg_book_apps/features/books/data/models/format_model.dart';
import 'package:guttenberg_book_apps/features/books/data/models/translator_model.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/book.dart';

class BookModel extends Book {
  final List<AuthorsModel>? authorsModel;
  final List<TranslatorModel>? translatorsModel;
  final FormatModel? formatModel;

  const BookModel({
    super.id,
    super.title,
    this.authorsModel,
    this.translatorsModel,
    super.subjects,
    super.bookshelves,
    super.languages,
    super.copyright,
    super.mediaType,
    this.formatModel,
    super.downloadCount,
  }) : super(
          authors: authorsModel,
          translators: translatorsModel,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'],
        title: json['title'],
        authorsModel: (json['authors'] as List)
            .map((e) => AuthorsModel.fromJson(e))
            .toList(),
        translatorsModel: json['translators'] == null
            ? []
            : (json['translators'] as List)
                .map((data) => TranslatorModel.fromJson(data))
                .toList(),
        bookshelves: json['bookshelves'] == null
            ? []
            : (json['bookshelves'] as List)
                .map((data) => data.toString())
                .toList(),
        languages: json['languages'] == null
            ? []
            : (json['languages'] as List)
                .map((data) => data.toString())
                .toList(),
        copyright: json['copyright'],
        mediaType: json['media_type'],
        subjects: json['subjects'] == null
            ? []
            : (json['subjects'] as List)
                .map((data) => data.toString())
                .toList(),
        formatModel: FormatModel.fromJson(json['formats']),
        downloadCount: json['download_count'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'authors': authorsModel!.map((authors) => authors.toJson()).toList(),
        'translators':
            translatorsModel!.map((translator) => translator.toJson()).toList(),
        'bookshelves': bookshelves,
        'languages': languages,
        'copyright': copyright,
        'media_type': mediaType,
        'formats': formatModel!.toJson(),
        'download_count': downloadCount,
      };

  static  Map<String, dynamic> toMap(BookModel bookModel) => {
        'id': bookModel.id,
        'title': bookModel.title,
        'authors': bookModel.authorsModel!.map((authors) => authors.toJson()).toList(),
        'translators':
            bookModel.translatorsModel!.map((translator) => translator.toJson()).toList(),
        'bookshelves': bookModel.bookshelves,
        'languages': bookModel.languages,
        'copyright': bookModel.copyright,
        'media_type': bookModel.mediaType,
        'formats': bookModel.formatModel!.toJson(),
        'download_count': bookModel.downloadCount,
      };

  static String encode(List<BookModel> books) => json.encode(
        books
            .map<Map<String, dynamic>>((book) => BookModel.toMap(book))
            .toList(),
      );

  static List<BookModel> decode(String bookModel) =>
      (json.decode(bookModel) as List<dynamic>)
          .map<BookModel>((item) => BookModel.fromJson(item))
          .toList();
}
