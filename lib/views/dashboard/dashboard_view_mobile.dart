import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/sizing.dart';
import 'package:flutter_test_project/views/dashboard/components/session_grid.dart';
import 'package:flutter_test_project/views/dashboard/components/shimmer_grid.dart';
import 'package:flutter_test_project/views/dashboard/components/time_filter.dart';
import 'package:flutter_test_project/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'clock/clock.dart';

class DashboardViewMobile extends StatefulWidget {
  final TimeFilterType initialFilter;
  final int crossAxisCount = 4;

  DashboardViewMobile({
    required this.initialFilter,
  });

  @override
  _DashboardViewMobileState createState() => _DashboardViewMobileState();
}

class _DashboardViewMobileState extends State<DashboardViewMobile> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              Clock(
                textStyle: TextStyle(fontSize: 16),
              ),
              Icon(
                Icons.account_circle_rounded,
                size: 24,
              ),
            ],
            bottom: TimeFilter(
              height: kToolbarHeight,
              initialFilter: widget.initialFilter,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: model.sessions != null
                  ? model.sessions!.length > 0
                      ? model.sessions!
                          .map(
                            (session) {
                              return <Widget>[
                                session.title,
                                SessionGrid(
                                  session: session,
                                  crossAxisCount: widget.crossAxisCount,
                                ),
                              ];
                            },
                          )
                          .reduce((value, element) => [...value, ...element])
                          .toList()
                      : <Widget>[
                          SizedBox(
                            height: Sizing.getSize(MediaQuery.of(context), 2),
                          ),
                          Center(
                            child: Text(
                              'Er zijn geen sessies gevonden voor de gekozen filter',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]
                  : <Widget>[
                      ShimmerGrid(
                        count: 6,
                        crossAxisCount: widget.crossAxisCount ~/ 4,
                      ),
                    ],
            ),
          ),
        );
      },
      viewModelBuilder: () => DashboardViewModel(
        context: context,
        crossAxisCount: widget.crossAxisCount,
        initialFilter: widget.initialFilter,
      ),
    );
  }
}
