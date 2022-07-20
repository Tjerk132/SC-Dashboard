// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarChartGraph _$BarChartGraphFromJson(Map<String, dynamic> json) =>
    BarChartGraph(
      title: json['title'] as String,
      barValues: (json['barValues'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      barTouchTooltipData: (json['barTouchTooltipData'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BarChartGraphToJson(BarChartGraph instance) =>
    <String, dynamic>{
      'title': instance.title,
      'barValues': instance.barValues,
      'barTouchTooltipData': instance.barTouchTooltipData,
    };
