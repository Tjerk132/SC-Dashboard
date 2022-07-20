enum PieChartType {
  divided,
  donut,
  circle,
  progression,
  gauge,
}

extension PieChartTypeExtension on PieChartType {
  double get sectionSpace {
    switch (this) {
      case PieChartType.divided:
        return 8.0; //6.0 + factor;
      case PieChartType.donut:
      case PieChartType.circle:
      case PieChartType.progression:
      case PieChartType.gauge:
        return 0;
    }
  }

  bool get showTitle {
    switch (this) {
      case PieChartType.divided:
      case PieChartType.donut:
        return true;
      case PieChartType.circle:
      case PieChartType.progression:
      case PieChartType.gauge:
        return false;
    }
  }

  bool get centerProgressIndicator {
    switch (this) {
      case PieChartType.divided:
      case PieChartType.donut:
      case PieChartType.circle:
        return false;
      case PieChartType.progression:
      case PieChartType.gauge:
        return true;
    }
  }
}
