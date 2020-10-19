import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/charts/chart_data/line_chart_data_samples.dart';
import 'package:flutter_test_project/models/charts/chart_data.dart';
import 'chart.dart';

class LineChartGraph extends Chart {
  LineChartGraph({this.lineWidth = 8});

  final double lineWidth;

  @override
  State<LineChartGraph> createState() => LineChartGraphState(this.lineWidth);
}

class LineChartGraphState extends State<LineChartGraph> {

  LineChartGraphState(double lineWidth)
      : samples = LineChartDataSamples(lineWidth) {
    isShowingMainData = true;
  }

  final LineChartDataSamples samples;

  bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
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
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  alignment: Alignment.topLeft,
                  icon: Icon(
                    Icons.refresh,
                    color:
                        Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      isShowingMainData = !isShowingMainData;
                    });
                  },
                ),
              ),
              ChartData(
                  data: isShowingMainData
                      ? samples.sampleData1()
                      : samples.sampleData2(),
                  title: 'Line chart title',
                  subTitle: 'Line Chart subtitle'),
            ],
          ),
        ),
      ),
    );
  }
}
