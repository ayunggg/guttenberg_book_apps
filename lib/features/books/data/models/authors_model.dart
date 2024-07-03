import 'package:guttenberg_book_apps/features/books/domain/entities/authors.dart';

class AuthorsModel extends Authors {
  const AuthorsModel({
    super.name,
    super.birthYear,
    super.deathYear,
  });

  factory AuthorsModel.fromJson(Map<String, dynamic> json) => AuthorsModel(
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
