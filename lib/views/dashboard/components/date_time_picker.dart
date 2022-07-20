import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDate;
  final double width;
  final double height;
  final Color backgroundColor;
  final TextStyle textStyle;
  final VoidCallback? onFocus;
  final Function(DateTime)? onSelected;

  DateTimePicker({
    Key? key,
    required this.initialDate,
    this.width = 110,
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

  void _onSelect() {
    widget.onFocus?.call();
    _selectDate();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      locale: Locale(Intl.defaultLocale!),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onSelected?.call(selectedDate);
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
          onTap: () => _onSelect(),
          child: Text(
            DateFormat.yMd().format(selectedDate),
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}
