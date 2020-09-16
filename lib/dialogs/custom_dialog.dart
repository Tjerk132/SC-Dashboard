import 'package:flutter/material.dart';
import 'package:flutter_test_project/dialogs/dialog_actions.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Map<DialogAction, Function()> actions;

  CustomDialog({
    Key key,
    @required this.title,
    @required this.message,
    @required this.icon,
    @required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          color: Colors.blue[500],
        ),
        padding: mediaQuery.orientation == Orientation.landscape ? EdgeInsets.all(12) : EdgeInsets.all(60),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
              child: Icon(icon, color: Colors.black),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      content: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 32,
          ),
          children: <TextSpan>[
            TextSpan(text: '$message\n'),
          ],
        ),
      ),
      actions: actions.keys.map<Widget>((key) {
        Function() action = actions[key];
        return RaisedButton(
          textColor: Colors.black,
          child: Text(key.type),
          onPressed: action,
        );
      }).toList(),
    );
  }
}