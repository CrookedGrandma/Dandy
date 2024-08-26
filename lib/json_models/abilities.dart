import 'package:json_annotation/json_annotation.dart';

part 'abilities.g.dart';

@JsonSerializable()
class Abilities {
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;

  Abilities(this.strength, this.dexterity, this.constitution, this.intelligence,
      this.wisdom, this.charisma);

  factory Abilities.fromJson(Map<String, dynamic> json) => _$AbilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$AbilitiesToJson(this);
}
