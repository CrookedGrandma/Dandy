import 'package:dandy/json_models/abilities.dart';
import 'package:dandy/json_models/person.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  @JsonKey(includeFromJson: false, includeToJson: false)
  late int dbId;

  String name;
  String imageBase64;
  Person? person;
  Abilities? abilities;

  Character(this.name, this.imageBase64, this.person, this.abilities);

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
