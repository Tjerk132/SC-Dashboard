import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_test_project/utility/utility.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final double width;
  final double height;
  final Color backgroundColor;
  final TextStyle textStyle;
  final VoidCallback onFocus;
  final Function(DateTime) onSelected;

  const DateTimePicker({
    Key key,
    this.initialDate,
    this.width = 100,
    this.height = 30,
    this.backgroundColor = Colors.white,
    this.textStyle = const TextStyle(color: Colors.black),
    this.onFocus,
    this.onSelected,
  }) : super(key: key);

  @override
  _DateTimePickerState createState() => _DateTimePickerState(this.initialDate);
}

class _DateTimePickerState extends State<DateTimePicker> {
  _DateTimePickerState(this.selectedDate);

  DateTime selectedDate;

  void _onSelected(BuildContext context) {
    if (widget.onFocus != null) {
      widget.onFocus();
    }
    _selectDate(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        locale: Locale('nl', 'NL'));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    if(widget.onSelected != null) {
      widget.onSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Center(
        child: GestureDetector(
          onTap: () => _onSelected(context),
          child: Text(
            selectedDate.formatToString(
              withDate: true,
              withTime: false,
              withSeconds: false,
            ),
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
