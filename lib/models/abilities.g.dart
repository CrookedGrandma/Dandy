// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Abilities _$AbilitiesFromJson(Map<String, dynamic> json) => Abilities(
      json['strength'] as int,
      json['dexterity'] as int,
      json['constitution'] as int,
      json['intelligence'] as int,
      json['wisdom'] as int,
      json['charisma'] as int,
    );

Map<String, dynamic> _$AbilitiesToJson(Abilities instance) => <String, dynamic>{
      'strength': instance.strength,
      'dexterity': instance.dexterity,
      'constitution': instance.constitution,
      'intelligence': instance.intelligence,
      'wisdom': instance.wisdom,
      'charisma': instance.charisma,
    };
