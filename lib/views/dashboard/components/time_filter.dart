import 'package:flutter/material.dart';
import 'package:flutter_test_project/enums/time_filter_type.dart';
import 'package:flutter_test_project/providers/time_filter_provider.dart';

import 'date_time_picker.dart';
import 'package:provider/provider.dart';

class TimeFilter extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final TimeFilterType initialFilter;

  TimeFilter({
    Key? key,
    required this.height,
    required this.initialFilter,
  }) : super(key: key);

  @override
  _TimeFilterState createState() => _TimeFilterState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _TimeFilterState extends State<TimeFilter> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late TimeFilterType filterType;

  /// These dates are adjusted with the methods [setStartDate]
  /// and [setEndDate] called from the onSelected method
  /// of [DateTimePicker]
  late DateTime start;
  late DateTime end;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      initialIndex: widget.initialFilter.index,
      length: TimeFilterType.values.length,
      vsync: this,
    );
    filterType = widget.initialFilter;
    // set the initial dates for the dateTimePickers
    start = widget.initialFilter.start;
    end = widget.initialFilter.end;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void tabChanged(int index) {
    filterType = TimeFilterType.values.firstWhere((type) => type.index == index);
    // Adjusted filter has non constant values and gets updated with
    // the methods [setStartDate] and [setEndDate]
    if(filterType == TimeFilterType.adjusted) {
      this.readContext(start, end);
    }
    else {
      this.readContext(filterType.start, filterType.end);
    }
  }

  // set startDate for adjusted timespan from start DateTimePicker
  void setStartDate(DateTime startDate) {
    start = startDate;
    this.readContext(start, end);
  }

  // set endDate for adjusted timespan from end DateTimePicker
  void setEndDate(DateTime endDate) {
    // add 1 day to also count all activities of the last day
    end = endDate.add(Duration(days: 1));
    this.readContext(start, end);
  }

  void readContext(DateTime start, DateTime end) {
    context.read<TimeFilterProvider>().onSelectedDate(
      context,
      filterType,
      start: start,
      end: end,
    );
  }

  /// adjust selected tabIndex when dateTimePicker is focused
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
                initialDate: start,
                onFocus: () => setTabIndex(2),
                onSelected: (DateTime selected) => setStartDate(selected),
              ),
              Text(' - '),
              DateTimePicker(
                initialDate: end,
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
