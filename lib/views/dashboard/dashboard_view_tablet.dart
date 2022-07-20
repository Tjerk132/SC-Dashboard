import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/models/skills/skill.dart';
import 'package:flutter_test_project/sizing.dart';
import 'package:flutter_test_project/views/dashboard/components/session_grid.dart';
import 'package:flutter_test_project/views/dashboard/components/shimmer_grid.dart';
import 'package:flutter_test_project/views/dashboard/components/time_filter.dart';
import 'package:flutter_test_project/views/dashboard/dashboard_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'clock/clock.dart';

class DashboardViewTablet extends StatefulWidget {
  final TimeFilterType initialFilter;
  final int crossAxisCount = 8;

  DashboardViewTablet({
    required this.initialFilter,
  });

  @override
  _DashboardViewTabletState createState() => _DashboardViewTabletState();
}

class _DashboardViewTabletState extends State<DashboardViewTablet> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
            actions: <Widget>[
              Clock(
                textStyle: TextStyle(fontSize: 20),
              ),
              Icon(
                Icons.account_circle_rounded,
                size: 30,
              ),
            ],
            bottom: TimeFilter(
              height: kToolbarHeight,
              initialFilter: widget.initialFilter,
            ),
          ),
          body: Column(
            children: model.sessions != null
                ? model.sessions!.length > 0
                    ? <Widget>[
                        SizedBox(
                          height: 180,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            itemExtent: 150,
                            children: model.skills,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  model.sessions!
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
                                      .toList(),
                            ),
                          ),
                        ),
                      ]
                    : <Widget>[
                        SizedBox(
                          height: Sizing.getSize(MediaQuery.of(context), 2),
                        ),
                        Align(
                          child: Text(
                            'Er zijn geen sessies gevonden voor de gekozen filter',
                            style: TextStyle(fontSize: 20),
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
