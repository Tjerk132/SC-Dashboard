import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SessionTitle extends StatefulWidget {

  final DateTime date;
  final EdgeInsets insets;
  final TextStyle style;

  SessionTitle({
    Key? key,
    required this.date,
    this.insets = EdgeInsets.zero,
    this.style = const TextStyle(),
  }) : super(key: key);

  @override
  _SessionTitleState createState() => _SessionTitleState();
}

class _SessionTitleState extends State<SessionTitle> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return Padding(
          padding: widget.insets,
          child: Text(
            'Sessie ${DateFormat('yyyy-MM-dd hh:mm').format(widget.date)}',
            style: TextStyle(fontSize: 18.0),
          ),
        );
      },
      tablet: (context) {
        return Padding(
          padding: widget.insets,
          child: Text(
            'Sessie ${DateFormat('yyyy-MM-dd hh:mm').format(widget.date)}',
            style: TextStyle(fontSize: 24.0),
          ),
        );
      },
    );
  }
}
