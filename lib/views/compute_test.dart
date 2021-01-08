import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ComputeTest extends StatefulWidget {
  @override
  _ComputeTestState createState() => _ComputeTestState();
}

class _ComputeTestState extends State<ComputeTest> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compute test'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
          FlatButton(
            onPressed: () async => print(await compute(press, 100000000)),
            child: Text("calculate computed")
          ),
          FlatButton(
            onPressed: () => print(press(100000000)),
            child: Text("calculate non-computed")
          ),
        ],
      )
    );
  }
}


int press(int max) {
  int sum = 0;
  for (int i = 0; i < max; ++i) {
    sum += i;
  }
  return sum;
}
