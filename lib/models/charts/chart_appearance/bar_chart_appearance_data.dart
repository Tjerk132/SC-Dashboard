class BarChartAppearanceData {
  final int factor;
  final double barWidth;

  BarChartAppearanceData({
    required this.factor,
  }) : barWidth = 12.0 + factor;
}
