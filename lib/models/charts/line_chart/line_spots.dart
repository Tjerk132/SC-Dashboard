import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class LineSpots {
  LineSpots({@required this.spots});

  final List<FlSpot> spots;

  /// convert the given json to a list of [FlSpot],
  /// the received json is a 2 dimensional
  /// array: [ [1,1], [2,1.5] etc. ]
  factory LineSpots.fromJson(List<dynamic> json) {
    List<FlSpot> spots = new List<FlSpot>();
    try {
      for (List<dynamic> lineCoordinates in json) {
        List<double> spotCoordinates = lineCoordinates.map<double>((e) => e.toDouble()).toList();
        spots.add(new FlSpot(spotCoordinates[0], spotCoordinates[1]));
      }
    } catch (e) {
      print(e);
    }
    return LineSpots(spots: spots);
  }
}
