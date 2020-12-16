import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';

import 'date_time_picker.dart';
import 'package:provider/provider.dart';

class TimeFilter extends StatefulWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final TimeFilterType initialFilterType;

  TimeFilter({
    Key key,
    this.appBarHeight,
    @required this.initialFilterType,
  }) : super(key: key) {
    assert(initialFilterType != null);
  }

  @override
  _TimeFilterState createState() => _TimeFilterState();

  @override
  Size get preferredSize => new Size.fromHeight(appBarHeight);
}

class _TimeFilterState extends State<TimeFilter>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TimeFilterType filterType;

  /// These dates are adjusted with the methods [setStartDate]
  /// and [setEndDate] called from the onSelected method
  /// of [DateTimePicker]
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      length: TimeFilterType.values.length,
      vsync: this,
    );
    this.setTabIndex(widget.initialFilterType.index);
    // set the initial dates for the dateTimePickers
    startDate = widget.initialFilterType.start;
    endDate = widget.initialFilterType.end;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void tabChanged(int index) {
    this.filterType = TimeFilterType.values.firstWhere((type) => type.index == index);
    // Adjusted filter has non constant values and gets updated with
    // the methods [setStartDate] and [setEndDate]
    if (this.filterType != TimeFilterType.Adjusted) {
      this.startDate = filterType.start;
      this.endDate = filterType.end;
    }
    this.readContext();
  }

  // set startDate for adjusted timespan from start DateTimePicker
  void setStartDate(DateTime startDate) {
    this.startDate = startDate;
    this.readContext();
  }

  // set endDate for adjusted timespan from end DateTimePicker
  void setEndDate(DateTime endDate) {
    // add 1 day to also count all activities of the last day
    this.endDate = endDate.add(Duration(days: 1));
    this.readContext();
  }

  void readContext() {
    context.read<TimeFilterProvider>().onSelectedDate(
      context,
      start: this.startDate,
      end: this.endDate,
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
      onTap: (index) => tabChanged(index),
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
                onSelected: (DateTime selected) => setStartDate(selected),
              ),
              Text(' - '),
              DateTimePicker(
                initialDate: endDate,
                onFocus: () => setTabIndex(2),
                onSelected: (DateTime selected) => setEndDate(selected),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
