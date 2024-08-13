// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      (json['level'] as num).toInt(),
      json['race'] as String,
      json['classs'] as String,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'level': instance.level,
      'race': instance.race,
      'classs': instance.classs,
    };
