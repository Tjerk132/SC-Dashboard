import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  final Duration updateInterval;
  final TextStyle textStyle;

  Clock({
    Key? key,
    this.updateInterval = const Duration(seconds: 1),
    this.textStyle = const TextStyle(),
  }) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _timeString = '';
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(widget.updateInterval, (Timer t) => _getCurrentTime());
    super.initState();
  }

  void _getCurrentTime() {
    if (mounted) {
      setState(() {
        _timeString = DateFormat('HH:mm').format(DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(_timeString, style: widget.textStyle),
      ),
    );
  }
}
