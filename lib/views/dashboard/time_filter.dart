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

  /// initial dates for the dateTimePickers, these dates are adjusted with the
  /// methods [setStartDate] and [setEndDate] called from the onSelected method
  /// of [DateTimePicker]
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void tabChanged(int index) {
    DateTime now = DateTime.now();
    //filter for last session (today)
    if (index == 0) {
      context.read<TimeFilterProvider>().onSelectedDate(
        startDate: DateTime(now.year, now.month, now.day),
        endDate: now,
      );
    }
    //filter for last week
    if (index == 1) {
      context.read<TimeFilterProvider>().onSelectedDate(
        startDate: now.subtract(Duration(days: 7)),
        endDate: now,
      );
    }
    //filter by given dates from DateTimePickers
    if (index == 2) {
      context.read<TimeFilterProvider>().onSelectedDate(
        startDate: startDate,
        endDate: endDate,
      );
    }
  }

  // set startDate for adjusted timespan from start DateTimePicker
  void setStartDate(DateTime startDate) {
    this.startDate = startDate;
    context.read<TimeFilterProvider>().onSelectedDate(startDate: startDate);
  }

  // set endDate for adjusted timespan from end DateTimePicker
  void setEndDate(DateTime endDate) {
    this.endDate = endDate;
    context.read<TimeFilterProvider>().onSelectedDate(endDate: endDate);
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
      onTap: (index) => tabChanged(index),
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: data.orientation == Orientation.landscape ? 120 : 40,
      ),
      isScrollable: true,
      tabs: <Tab>[
        Tab(text: 'Laatste sessie'),
        Tab(text: 'Laatste 7 dagen'),
        Tab(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 9.0),
                child: Text('Aangepast'),
              ),
              DateTimePicker(
                initialDate: startDate,
                onFocus: () => setTabIndex(2),
                onSelected: (DateTime selectedDate) =>
                    setStartDate(selectedDate),
              ),
              Text(' - '),
              DateTimePicker(
                initialDate: endDate,
                onFocus: () => setTabIndex(2),
                onSelected: (DateTime selectedDate) => setEndDate(selectedDate),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
