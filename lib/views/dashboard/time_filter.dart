import 'package:flutter/material.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';

import 'date_time_picker.dart';
import 'package:provider/provider.dart';

class TimeFilter extends StatefulWidget implements PreferredSizeWidget {
  final double appBarHeight;

  TimeFilter({
    Key key,
    this.appBarHeight,
  }) : super(key: key);

  @override
  _TimeFilterState createState() => _TimeFilterState();

  @override
  Size get preferredSize => new Size.fromHeight(appBarHeight);
}

class _TimeFilterState extends State<TimeFilter>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  /// These dates are adjusted with the methods [setStartDate]
  /// and [setEndDate] called from the onSelected method
  /// of [DateTimePicker]
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    // set the initial dates for the dateTimePickers
    DateTime now = DateTime.now();
    startDate = DateTime(now.year, now.month, now.day);
    endDate = startDate.add(Duration(days: 7));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void tabChanged(BuildContext context, int index) {
    DateTime now = DateTime.now();
    if (index == 0) {
      //filter for last session (today)
      context.read<TimeFilterProvider>().onSelectedDate(
        context,
        startDate: DateTime(now.year, now.month, now.day),
        endDate: now,
      );
    }
    else if (index == 1) {
      //filter for last week
      context.read<TimeFilterProvider>().onSelectedDate(
        context,
        startDate: now.subtract(Duration(days: 7)),
        endDate: now,
      );
    }
    else if (index == 2) {
      //filter by given dates from DateTimePickers
      context.read<TimeFilterProvider>().onSelectedDate(
        context,
        startDate: startDate,
        // add 1 day to also count all activities of the last day
        endDate: endDate.add(Duration(days: 1)),
      );
    }
  }

  // set startDate for adjusted timespan from start DateTimePicker
  void setStartDate(BuildContext context, DateTime startDate) {
    this.startDate = startDate;
    context.read<TimeFilterProvider>().onSelectedDate(
      context,
      startDate: this.startDate,
    );
  }

  // set endDate for adjusted timespan from end DateTimePicker
  void setEndDate(BuildContext context, DateTime endDate) {
    // add 1 day to also count all activities of the last day
    this.endDate = endDate.add(Duration(days: 1));
    context.read<TimeFilterProvider>().onSelectedDate(
      context,
      endDate: this.endDate,
    );
  }

  /// adjust selected tabIndex (for dateTimePickers)
  void setTabIndex(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    return TabBar(
      controller: _tabController,
      onTap: (index) => tabChanged(context, index),
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: data.orientation == Orientation.landscape ? 110 : 30,
      ),
      isScrollable: true,
      tabs: <Tab>[
        Tab(text: 'Laatste sessie'),
        Tab(text: 'Laatste 7 dagen'),
        Tab(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 7.0),
                child: Text('Aangepast'),
              ),
              DateTimePicker(
                initialDate: startDate,
                onFocus: () => setTabIndex(2),
                onSelected: (DateTime selectedDate) =>
                    setStartDate(context, selectedDate),
              ),
              Text(' - '),
              DateTimePicker(
                initialDate: endDate,
                onFocus: () => setTabIndex(2),
                onSelected: (DateTime selectedDate) =>
                    setEndDate(context, selectedDate),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
