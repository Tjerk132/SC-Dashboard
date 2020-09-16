import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkHighLights extends StatelessWidget {

  LinkHighLights({this.highLightUrls});

  final String highLightUrls;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 5 : 4,
      children: List.generate(20, (index) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[500])),
          margin: EdgeInsets.all(2.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    child: Image.asset(
                      highLightUrls,
                    )),
                Container(
                  color: Colors.grey[500],
                  padding: EdgeInsets.only(left: 2.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "HIGHLIGHT $index",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 9, color: Colors.grey[200]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Highlight tab name",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        );
      }),
    );
  }
}