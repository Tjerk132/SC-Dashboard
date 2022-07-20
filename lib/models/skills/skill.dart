import 'package:flutter/material.dart';
import 'package:flutter_test_project/app/locator.dart';
import 'package:flutter_test_project/enums/pie_chart_type.dart';
import 'package:flutter_test_project/enums/tile_group_type.dart';
import 'package:flutter_test_project/models/charts/chart.dart';
import 'package:flutter_test_project/models/charts/pie_chart/pie_chart.dart';
import 'package:flutter_test_project/services/group_type_service.dart';

class Skill extends StatelessWidget {
  final GroupTypeService _groupTypeService = locator<GroupTypeService>();

  final String title;
  final double percentage;
  final Color color;
  final IconData icon;
  final Chart chart;

  Skill({
    Key? key,
    required this.title,
    required this.percentage,
    required this.color,
    required this.icon,
  })  : chart = PieChartGraph(
          title: title,
          values: [percentage, 100 - percentage],
          // indicatorText: ['Progression for this skill'],
          sectionColors: [color, Colors.grey[200]!],
          pieChartType: PieChartType.gauge,
        ),
        super(key: key) {
    _groupTypeService.addGroupTypes({
      TileGroupType.small: [chart]
    });
  }

  @override
  Widget build(BuildContext context) {
    return chart;
  }
}
