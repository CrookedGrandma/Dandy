// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Abilities _$AbilitiesFromJson(Map<String, dynamic> json) => Abilities(
      (json['strength'] as num).toInt(),
      (json['dexterity'] as num).toInt(),
      (json['constitution'] as num).toInt(),
      (json['intelligence'] as num).toInt(),
      (json['wisdom'] as num).toInt(),
      (json['charisma'] as num).toInt(),
    );

Map<String, dynamic> _$AbilitiesToJson(Abilities instance) => <String, dynamic>{
      'strength': instance.strength,
      'dexterity': instance.dexterity,
      'constitution': instance.constitution,
      'intelligence': instance.intelligence,
      'wisdom': instance.wisdom,
      'charisma': instance.charisma,
    };
