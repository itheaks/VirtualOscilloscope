import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

void main() => runApp(GraphApp());

class GraphApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GraphScreen(),
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint(this.x, this.y);
}

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  int numberOfConstraints = 0;
  List<DataPoint> constraintsData = [];
  String xAxisName = '';
  String yAxisName = '';

  List<DataPoint> getSineData() {
    List<DataPoint> data = [];
    for (double i = 0; i <= 2 * pi; i += 0.1) {
      data.add(DataPoint(i, sin(i)));
    }
    return data;
  }

  List<DataPoint> getSquareWaveData() {
    List<DataPoint> data = [];
    for (double i = 0; i <= 2 * pi; i += 0.1) {
      data.add(DataPoint(i, sin(i) >= 0 ? 1.0 : -1.0));
    }
    return data;
  }

  void _showGraph(List<DataPoint> data, String title) {
    List<ChartSeries<DataPoint, double>> series = [
      SplineSeries<DataPoint, double>(
        dataSource: data,
        xValueMapper: (DataPoint data, _) => data.x,
        yValueMapper: (DataPoint data, _) => data.y,
      ),
    ];

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              primary: true,
            ),
            body: Center(
              child: SfCartesianChart(
                title: ChartTitle(text: title),
                primaryXAxis: NumericAxis(title: AxisTitle(text: xAxisName)),
                primaryYAxis: NumericAxis(title: AxisTitle(text: yAxisName)),
                series: series,
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  enablePinching: true,
                  enableDoubleTapZooming: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _inputConstraints() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Graph Details'),
          content: Container(
            height: 300,
            child: Column(
              children: [
                Text('X Axis Name:'),
                TextFormField(
                  onChanged: (value) {
                    xAxisName = value;
                  },
                ),
                SizedBox(height: 10),
                Text('Y Axis Name:'),
                TextFormField(
                  onChanged: (value) {
                    yAxisName = value;
                  },
                ),
                SizedBox(height: 10),
                Text('Number of Constraints:'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      numberOfConstraints = int.tryParse(value) ?? 0;
                      constraintsData = List.generate(numberOfConstraints, (_) => DataPoint(0.0, 0.0));
                    });
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showConstraintsInput();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConstraintsInput() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Constraint Values'),
          content: Container(
            height: 300,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < numberOfConstraints; i++)
                    Row(
                      children: [
                        Expanded(child: Text('X${i + 1}')),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                constraintsData[i] =
                                    DataPoint(double.tryParse(value) ?? 0, constraintsData[i].y);
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(child: Text('Y${i + 1}')),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                constraintsData[i] =
                                    DataPoint(constraintsData[i].x, double.tryParse(value) ?? 0);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showGraph(constraintsData, 'Graph');
                _showGraph(getSineData(), 'Sine Wave');
                _showGraph(getSquareWaveData(), 'Square Wave');
              },
              child: Text('Plot Graphs'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "CREATE YOUR CSV FILE",
            style: TextStyle(color: Color(0xFF39FF14)),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _inputConstraints();
              },
              child: Text('Enter Constraints',style: TextStyle(fontSize: 28)),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Color(0xFF39FF14), // Text color
                shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Color(0xFF39FF14), // Color of the outline
                    width: 3, // Adjust the width of the outline
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}