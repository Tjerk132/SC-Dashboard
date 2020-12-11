// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarChartGraph _$BarChartGraphFromJson(Map<String, dynamic> json) {
  return BarChartGraph(
    title: json['title'] as String,
    subTitle: json['subTitle'] as String,
    barValues: (json['barValues'] as List)
        ?.map((e) => (e as num)?.toDouble())
        ?.toList(),
    barTouchTooltipData: (json['barTouchTooltipData'] as List)
        ?.map((e) => e as String)
        ?.toList(),
  );
}

Map<String, dynamic> _$BarChartGraphToJson(BarChartGraph instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'barValues': instance.barValues,
      'barTouchTooltipData': instance.barTouchTooltipData,
    };
