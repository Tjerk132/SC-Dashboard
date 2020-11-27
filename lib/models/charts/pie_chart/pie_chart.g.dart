// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PieChartGraph _$PieChartGraphFromJson(Map<String, dynamic> json) {
  return PieChartGraph(
    title: json['title'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    pieCount: json['pieCount'] as int,
    values:
        (json['values'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
    indicatorText:
        (json['indicatorText'] as List)?.map((e) => e as String)?.toList(),
    sectionColors: PieChartGraph._colorsFromJson(json['sectionColors'] as List),
  );
}

Map<String, dynamic> _$PieChartGraphToJson(PieChartGraph instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'pieCount': instance.pieCount,
      'values': instance.values,
      'indicatorText': instance.indicatorText,
      'sectionColors': PieChartGraph._colorsToJson(instance.sectionColors),
    };
