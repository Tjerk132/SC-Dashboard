import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopLinks extends StatelessWidget {

  TopLinks({this.topLinkUrls});

  final String topLinkUrls;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 6,
      children: List.generate(6, (index) {
        return Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: new Image.asset(topLinkUrls),
          ),
          Text(
            "top site $index",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ]);
      }),
    );
  }
}