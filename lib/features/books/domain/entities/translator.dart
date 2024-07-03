import 'package:equatable/equatable.dart';

class Translator extends Equatable {
   final String? name;
  final int? birthYear;
  final int? deathYear;

  const Translator({
    this.name,
    this.birthYear,
    this.deathYear,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        birthYear,
        deathYear,
      ];
  
}