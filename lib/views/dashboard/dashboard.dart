import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test_project/device_type.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/logic/dashboard_logic.dart';
import 'package:flutter_test_project/models/session/session.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';
import 'package:flutter_test_project/sizing.dart';
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
  TimeFilterProvider provider;
  Future<List<Session>> _future;
  final TimeFilterType initialFilter = TimeFilterType.lastWeek;

  @override
  void initState() {
    _logic = new DashboardLogic(widget.crossAxisCount);

    provider = context.read<TimeFilterProvider>();
    provider.addListener(providerCallback);

    _future = this.getFuture(byProvider: false);
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
        _future = this.getFuture();
      });
    }
  }

  Future<List<Session>> getFuture({bool byProvider = true}) {
    if ((byProvider ? provider.type : initialFilter) == TimeFilterType.lastSession) {
      return _logic.lastSession(context);
    }
    else {
      return _logic.sessions(
        context,
        start: byProvider ? provider.start : initialFilter.start,
        end: byProvider ? provider.end : initialFilter.end,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
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
          initialFilter: initialFilter,
        ),
      ),
      body: FutureBuilder<List<Session>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<Session>> snapshot) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(height: Sizing.getSize(mediaQuery, 2)),
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
                        availableSizes: <int>[1, 4],
                      ),
                    ],
            ),
          );
        },
      ),
    );
  }
}
