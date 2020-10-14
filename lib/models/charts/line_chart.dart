import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart_data/line_chart_data_samples.dart';
import 'package:flutter_test_project/models/charts/chart_title.dart';
import 'chart.dart';

class LineChartGraph extends Chart {
  LineChartGraph(int index) : super(index);

  @override
  State<StatefulWidget> createState() => LineChartGraphState();
}

class LineChartGraphState extends State<LineChartGraph> {
  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: const [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ChartTitle(
              data: isShowingMainData
                  ? LineChartDataSamples().sampleData1()
                  : LineChartDataSamples().sampleData2(),
              index: widget.index,
              title: 'Line chart title',
              subTitle: 'Line Chart subtitle'),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
