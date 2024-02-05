import 'package:dandy/models/person.dart';
import 'package:json_annotation/json_annotation.dart';
import 'abilities.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  String name;
  String imageBase64;
  Person? person;
  Abilities? abilities;

  Character(this.name, this.imageBase64, this.person, this.abilities);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
