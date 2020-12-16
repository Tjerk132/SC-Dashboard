import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_project/device_type.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_test_project/models/session/session.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';
import 'package:flutter_test_project/views/dashboard/session_grid.dart';
import 'package:flutter_test_project/views/dashboard/shimmer_grid.dart';
import 'package:flutter_test_project/views/dashboard/time_filter.dart';
import 'package:provider/provider.dart';

import 'clock/clock.dart';

class Dashboard extends StatefulWidget {
  final int crossAxisCount = DeviceType().isPhone ? 4 : 8;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardLogic _logic;
  Future<List<Session>> _future;
  TimeFilterProvider provider;
  final TimeFilterType initialFilterType = TimeFilterType.LastWeek;

  @override
  void initState() {
    _logic = new DashboardLogic(widget.crossAxisCount);

    provider = context.read<TimeFilterProvider>();
    provider.addListener(providerCallback);

    _future = _logic.groups(
      context,
      start: initialFilterType.start,
      end: initialFilterType.end,
    );
    super.initState();
  }

  @override
  void dispose() {
    provider?.removeListener(providerCallback);
    super.dispose();
  }

  void providerCallback() {
    if (this.mounted) {
      setState(() {
        _future = _logic.groups(
          context,
          start: provider.start,
          end: provider.end,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          appBarHeight: AppBar().preferredSize.height,
          initialFilterType: initialFilterType,
        ),
      ),
      body: FutureBuilder<List<Session>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<Session>> snapshot) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: snapshot.hasData
                    ? snapshot.data.length > 0
                        ? snapshot.data
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
                            Text(
                              'Er zijn geen sessies gevonden voor de gekozen filter',
                              style: TextStyle(fontSize: 20),
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
      ),
    );
  }
}
