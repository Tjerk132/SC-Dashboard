// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineChartGraph _$LineChartGraphFromJson(Map<String, dynamic> json) {
  return LineChartGraph(
    title: json['title'] as String,
    subTitle: json['subTitle'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    lineWidth: (json['lineWidth'] as num)?.toDouble(),
    lineCount: json['lineCount'] as int,
    topTitles: (json['topTitles'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    bottomTitles: (json['bottomTitles'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    leftTitles: (json['leftTitles'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    rightTitles: (json['rightTitles'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    ),
    spots: LineChartGraph._spotsFromJson(json['spots'] as Map<String, dynamic>),
    colors:
        LineChartGraph._colorsFromJson(json['colors'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LineChartGraphToJson(LineChartGraph instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'date': instance.date?.toIso8601String(),
      'lineWidth': instance.lineWidth,
      'lineCount': instance.lineCount,
      'topTitles': instance.topTitles?.map((k, e) => MapEntry(k.toString(), e)),
      'bottomTitles':
          instance.bottomTitles?.map((k, e) => MapEntry(k.toString(), e)),
      'leftTitles':
          instance.leftTitles?.map((k, e) => MapEntry(k.toString(), e)),
      'rightTitles':
          instance.rightTitles?.map((k, e) => MapEntry(k.toString(), e)),
      'spots': LineChartGraph._spotsToJson(instance.spots),
      'colors': LineChartGraph._colorsToJson(instance.colors),
    };
