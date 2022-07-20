// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pie_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PieChartGraph _$PieChartGraphFromJson(Map<String, dynamic> json) =>
    PieChartGraph(
      title: json['title'] as String,
      sectionColors:
          PieChartGraph._colorsFromJson(json['sectionColors'] as List),
      pieChartType: $enumDecode(_$PieChartTypeEnumMap, json['pieChartType']),
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      indicatorText: (json['indicatorText'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PieChartGraphToJson(PieChartGraph instance) =>
    <String, dynamic>{
      'title': instance.title,
      'values': instance.values,
      'indicatorText': instance.indicatorText,
      'sectionColors': PieChartGraph._colorsToJson(instance.sectionColors),
      'pieChartType': _$PieChartTypeEnumMap[instance.pieChartType],
    };

const _$PieChartTypeEnumMap = {
  PieChartType.divided: 'divided',
  PieChartType.donut: 'donut',
  PieChartType.circle: 'circle',
  PieChartType.progression: 'progression',
  PieChartType.gauge: 'gauge',
};
