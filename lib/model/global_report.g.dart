// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalReport _$GlobalReportFromJson(Map<String, dynamic> json) {
  return GlobalReport(
    Global.fromJson(json['Global']),
    (json['Countries'] as List)
        ?.map((e) => e == null
            ? null
            : CountryReport.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GlobalReportToJson(GlobalReport instance) =>
    <String, dynamic>{
      'Countries': instance.countries,
    };
