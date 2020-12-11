import 'package:flutter/material.dart';

class Sizing {
  static double getSize(MediaQueryData mediaQuery, double divider,
      {double multiplier, bool reverse}) {
    double landscapeRatio = mediaQuery.orientation == Orientation.portrait
        ? mediaQuery.size.height / mediaQuery.size.width
        : mediaQuery.size.width / mediaQuery.size.height;
    double _multiplier = multiplier != null && multiplier > 0 ? multiplier : 1;
    return reverse == null || !reverse
        ? (mediaQuery.orientation == Orientation.portrait
          ? mediaQuery.size.width / divider
          : mediaQuery.size.width / divider / landscapeRatio * _multiplier)
        .roundToDouble()
        : (mediaQuery.orientation == Orientation.portrait
          ? mediaQuery.size.height / divider / landscapeRatio * _multiplier
          : mediaQuery.size.height / divider)
        .roundToDouble();
  }

  static double getSizeConstraint(
      MediaQueryData mediaQuery, BoxConstraints constraint, double divider,
      {double multiplier, bool reverse}) {
    double _multiplier = multiplier != null && multiplier > 0 ? multiplier : 1;
    return reverse == null || !reverse
        ? (constraint.biggest.width / divider * _multiplier).roundToDouble()
        : (constraint.biggest.height / divider * _multiplier).roundToDouble();
  }
}