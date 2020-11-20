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
              onPressed: () async {
                int sum = await compute(press, 100000000);
                print(sum);
              },
              child: Text("calculate computed")
          ),
          FlatButton(
              onPressed: () async {
                int sum = press(100000000);
                print(sum);
              },
              child: Text("calculate non-computed")
          ),
//        LineChartSample1(),
//        PieChartSample1(),
//        BarChartGraph(),
        ],
      )
    );
  }
}


int press(int max) {
  int sum = 0;
  DateTime start = DateTime.now();
  for (int i = 0; i < max; ++i) {
    sum += i;
  }
  DateTime end = DateTime.now();
  print('done in:  ${end.difference(start).inMilliseconds}');
  return sum;
}
