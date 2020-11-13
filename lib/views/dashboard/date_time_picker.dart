import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_test_project/utility/utility.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final double width;
  final double height;

  const DateTimePicker({
    Key key,
    this.initialDate,
    this.width = 100,
    this.height = 30,
  }) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState(this.initialDate);
}

class _DateTimePickerState extends State<DateTimePicker> {
  _DateTimePickerState(this.selectedDate);

  DateTime selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: Locale('nl','NL')
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.white,
        child: Center(
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Text(
              '${selectedDate.
              formatToString(
                withDate: true,
                withTime: false,
                withSeconds: false,
              )}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
