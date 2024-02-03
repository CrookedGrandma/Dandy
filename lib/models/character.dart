import 'package:json_annotation/json_annotation.dart';
import 'abilities.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  String name;
  String imageBase64;
  Abilities abilities;

  Character(this.name, this.imageBase64, this.abilities);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
