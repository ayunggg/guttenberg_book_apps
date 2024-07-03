import 'package:guttenberg_book_apps/features/books/domain/entities/translator.dart';

class TranslatorModel extends Translator {
  const TranslatorModel({
    super.name,
    super.birthYear,
    super.deathYear,
  });

  factory TranslatorModel.fromJson(Map<String, dynamic> json) =>
      TranslatorModel(
        name: json['name'],
        birthYear: json['birth_year'],
        deathYear: json['death_year'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'birth_year': birthYear,
        'death_year': deathYear,
      };
}
