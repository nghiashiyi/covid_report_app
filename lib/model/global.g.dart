// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Global _$GlobalFromJson(Map<String, dynamic> json) {
  return Global(
    json['TotalConfirmed'] as int,
    json['TotalDeaths'] as int,
    json['TotalRecovered'] as int,
  );
}

Map<String, dynamic> _$GlobalToJson(Global instance) =>
    <String, dynamic>{
      'TotalConfirmed': instance.totalConfirmed,
      'TotalDeaths': instance.totalDeaths,
      'TotalRecovered': instance.totalRecovered,
    };
