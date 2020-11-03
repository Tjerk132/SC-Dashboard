class BarChartAppearanceData {

  int singularSize;
  double barWidth;

  BarChartAppearanceData({
    this.singularSize,
  }) {
    this.barWidth = 12.0 + singularSize;
  }
}