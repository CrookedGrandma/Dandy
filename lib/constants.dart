import 'package:dandy/models/named_field.dart';
import 'package:darq/darq.dart';

class Constants {
  static Map<String, List<NamedField>> fields = {
    "Basics": [
      NamedField<String>("Character name", "name"),
    ],
    "Person": [
      NamedField<int>("Level", "person/level"),
      NamedField<String>("Race", "person/race"),
      NamedField<String>("Class", "person/class"),
    ],
    "Abilities": [
      NamedField<int>("Strength", "abilities/strength"),
      NamedField<int>("Dexterity", "abilities/dexterity"),
      NamedField<int>("Constitution", "abilities/constitution"),
      NamedField<int>("Intelligence", "abilities/intelligence"),
      NamedField<int>("Wisdom", "abilities/wisdom"),
      NamedField<int>("Charisma", "abilities/charisma"),
    ]
  };

  static List<NamedField> get fieldsFlat
    => fields.entries.selectMany((entry, i) => entry.value).toList();
}