import 'package:equatable/equatable.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/authors.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/formats.dart';
import 'package:guttenberg_book_apps/features/books/domain/entities/translator.dart';

class Book extends Equatable {
  final int? id;
  final String? title;
  final List<Authors>? authors;
  final List<Translator>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;

  

  const Book({
    this.id,
    this.title,
    this.authors,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        authors,
        translators,
        subjects,
        bookshelves,
        languages,
        copyright,
        mediaType,
        formats,
        downloadCount,
      ];
}
