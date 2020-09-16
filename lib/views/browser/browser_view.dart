import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test_project/views/browser/top_links_view.dart';
import 'package:flutter_test_project/views/compute_test.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

import '../dashboard/dashboard_view.dart';
import 'link_highlights_view.dart';

class BrowserView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BrowserViewState();
}

TextEditingController _textEditingController = new TextEditingController();

class BrowserViewState extends State<BrowserView> {

  bool searched = false;

  String about = '<h3>About</h3>';
  String hits = '<h4>Are you reffering to..</h4>';
  String reviews = '<h4>Reviews</h4>';

  Future searchBrowser() async {

    about = '<h3>About</h3>';
    hits = '<h4>Are you reffering to..</h4>';
    reviews = '<h4>Reviews</h4>';

    String input = _textEditingController.text;
    try {
      final Map<String, String> queryParams = {
        'query': input
      };
      Uri uri = Uri.https("google.com", '/search', queryParams);
      print('Searching uri: $uri');

      final result = await http.get(uri);

      var document = parse(result.body);

      bool aboutFetched = false;

      document.querySelectorAll("div").forEach((value) {
          if (value.className == ("BNeawe s3v9rd AP7Wnd") && !aboutFetched) {
            about +=  value.innerHtml;
            aboutFetched = true;
          }
          if (value.className == ("BNeawe vvjwJb AP7Wnd")) {
            hits +=  (value.innerHtml + '<br/><br/>') ;
          }
          if (value.className == ("v9i61e")) {
            reviews +=  value.innerHtml;
          }
//         UDZeY OTFaAf
      });

      _textEditingController.clear();
      setState(() => searched = true);

    } on SocketException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browser Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () =>
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              )
            }
          ),
          IconButton(
              icon: Icon(Icons.wifi),
              onPressed: () =>
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComputeTest()),
                )
              }
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => setState(() => searched = false),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              Container(
                padding: new EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 5.0),
                child: TextField(
                  controller: _textEditingController,
                  onSubmitted: (value) => searchBrowser(),
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
              if(searched)
              ...[
                Text("Resultaten:"),
                Html(data: about),
                Html(data: hits),
                Html(data: reviews),
              ]
              else
              ...[
                TopLinks(topLinkUrls: 'lib/assets/youtube.jpg'),
                Divider(height: 10.0),
                LinkHighLights(highLightUrls: 'lib/assets/youtube.jpg'),
              ]
            ]),
          )),
    );
  }
}
