import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_project/context_navigator.dart';
import 'package:flutter_test_project/views/browser/top_links_view.dart';
import 'package:flutter_test_project/views/compute_test.dart';
import 'package:flutter_test_project/views/slot_machine/slotmachine_view.dart';

import '../dashboard/dashboard_view.dart';
import 'link_highlights_view.dart';

class BrowserView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BrowserViewState();
}

TextEditingController _textEditingController = new TextEditingController();

class BrowserViewState extends State<BrowserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browser Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.money),
            onPressed: () => ContextNavigator.push(context, SlotMachine()),
          ),
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () => ContextNavigator.push(context, Dashboard()),
          ),
          IconButton(
            icon: Icon(Icons.wifi),
            onPressed: () => ContextNavigator.push(context, ComputeTest()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    new EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextField(
                  controller: _textEditingController,
                  onSubmitted: (value) => null,
                  decoration: InputDecoration(
                    hintText: 'Search the Web',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TopLinks(topLinkUrls: 'lib/assets/youtube.jpg'),
              Divider(height: 10.0),
              LinkHighLights(highLightUrls: 'lib/assets/youtube.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}
