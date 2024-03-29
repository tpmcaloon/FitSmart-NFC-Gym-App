import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialBarDefault extends StatelessWidget {
  const RadialBarDefault({super.key});


  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Squat', 150, const Color.fromRGBO(30, 215, 96, 1)),
      ChartData('Bench Press', 70, const Color.fromRGBO(30, 215, 96, 1)),
      ChartData('Deadlift', 180, const Color.fromRGBO(30, 215, 96, 1)),
      ChartData('Pull Ups', 70, const Color.fromRGBO(30, 215, 96, 1)),
    ];

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Expanded(
        child: Scaffold(
            body: Center(
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        width: w,
                        height: h*0.1,
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                        child: SfCircularChart(
                          borderWidth: 2,
                          borderColor: const Color.fromRGBO(30, 215, 96, 1),
                          backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
                          legend: Legend(isVisible: true, textStyle: const TextStyle(color: Colors.white)),
                          title: ChartTitle(
                            text: 'Daily Goals',
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          series: <CircularSeries>[
                            RadialBarSeries<ChartData, String>(
                                gap: '5',
                                pointColorMapper: (ChartData data, _) => data.color,
                                trackColor: const Color.fromRGBO(30, 215, 96, 1),
                                useSeriesColor: true,
                                trackOpacity: 0.3,
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    color: Color.fromRGBO(50, 50, 50, 1),
                                    textStyle: TextStyle(color: Colors.white)
                                ),
                                radius: '75%',
                                innerRadius: '35%',
                                cornerStyle: CornerStyle.endCurve
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: w,
                        height: h*0.1,
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(),
                          plotAreaBorderColor: Colors.transparent,
                          borderWidth: 2,
                          borderColor: const Color.fromRGBO(30, 215, 96, 1),
                          backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
                          legend: Legend(
                            isVisible: true,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                          title: ChartTitle(
                            text: 'Daily Goals',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<ChartData, String>(
                              color: const Color.fromRGBO(30, 215, 96, 1),
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                            ),
                          ],
                        ),
                      ),
                    ]),
            ),
        )
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

