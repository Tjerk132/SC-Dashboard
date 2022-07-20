// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineChartGraph _$LineChartGraphFromJson(Map<String, dynamic> json) =>
    LineChartGraph(
      title: json['title'] as String,
      lineWidth: (json['lineWidth'] as num?)?.toDouble() ?? 8,
      topTitles: (json['topTitles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
      bottomTitles: (json['bottomTitles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
      leftTitles: (json['leftTitles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
      rightTitles: (json['rightTitles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
      spots: json['spots'] == null
          ? const {}
          : LineChartGraph._spotsFromJson(
              json['spots'] as Map<String, dynamic>),
      color: LineChartGraph._colorsFromJson(json['color']),
    );

Map<String, dynamic> _$LineChartGraphToJson(LineChartGraph instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lineWidth': instance.lineWidth,
      'topTitles': instance.topTitles.map((k, e) => MapEntry(k.toString(), e)),
      'bottomTitles':
          instance.bottomTitles.map((k, e) => MapEntry(k.toString(), e)),
      'leftTitles':
          instance.leftTitles.map((k, e) => MapEntry(k.toString(), e)),
      'rightTitles':
          instance.rightTitles.map((k, e) => MapEntry(k.toString(), e)),
      'spots': LineChartGraph._spotsToJson(instance.spots),
      'color': LineChartGraph._colorsToJson(instance.color),
    };
