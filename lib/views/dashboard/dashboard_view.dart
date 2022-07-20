import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test_project/views/dashboard/dashboard_view_mobile.dart';
import 'package:flutter_test_project/views/dashboard/dashboard_view_tablet.dart';

class DashboardView extends StatelessWidget {
  final TimeFilterType initialFilter = TimeFilterType.adjusted;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => DashboardViewMobile(
        initialFilter: initialFilter,
      ),
      tablet: (context) => DashboardViewTablet(
        initialFilter: initialFilter,
      ),
    );
  }
}
