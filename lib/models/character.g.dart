// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['name'] as String,
      json['imageBase64'] as String,
      json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
      json['abilities'] == null
          ? null
          : Abilities.fromJson(json['abilities'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'imageBase64': instance.imageBase64,
      'person': instance.person,
      'abilities': instance.abilities,
    };
