import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionTitle extends StatefulWidget {

  final DateTime date;
  final EdgeInsets insets;

  SessionTitle({
    Key key,
    this.date,
    this.insets = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _SessionTitleState createState() => _SessionTitleState();
}

class _SessionTitleState extends State<SessionTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.insets,
      child: Text(
        'Sessie ${DateFormat('yyyy-MM-dd hh:mm').format(widget.date)}',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
