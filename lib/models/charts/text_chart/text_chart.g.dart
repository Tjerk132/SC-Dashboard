// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextChart _$TextChartFromJson(Map<String, dynamic> json) {
  return TextChart(
    title: json['title'] as String,
    content: json['content'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$TextChartToJson(TextChart instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'content': instance.content,
    };
