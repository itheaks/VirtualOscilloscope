import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:file_picker/file_picker.dart';

void main() => runApp(GraphApp());

class GraphApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImportCsvScreen(),
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint(this.x, this.y);
}

class ImportCsvScreen extends StatefulWidget {
  @override
  _ImportCsvScreenState createState() => _ImportCsvScreenState();
}

class _ImportCsvScreenState extends State<ImportCsvScreen> {
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

  void _showGraphFullScreen(List<DataPoint> data, String title) {
    List<ChartSeries<DataPoint, double>> series = [
      SplineSeries<DataPoint, double>(
        dataSource: data,
        xValueMapper: (DataPoint data, _) => data.x,
        yValueMapper: (DataPoint data, _) => data.y,
      ),
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height - 100,
            child: SfCartesianChart(
              title: ChartTitle(text: title),
              primaryXAxis: NumericAxis(title: AxisTitle(text: xAxisName)),
              primaryYAxis: NumericAxis(title: AxisTitle(text: yAxisName)),
              series: series,
              zoomPanBehavior: ZoomPanBehavior(
                enableDoubleTapZooming: true,
                enablePanning: true,
                enablePinching: true,
              ),
            ),
          ),
        );
      },
    );
  }

  void _inputConstraints() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      String csvString = String.fromCharCodes(file.bytes!);
      List<DataPoint> csvData = _parseCSVData(csvString);

      if (csvData.isNotEmpty) {
        await _getAxisNames();

        setState(() {
          constraintsData = csvData;
          numberOfConstraints = constraintsData.length;
        });
        _showGraphFullScreen(constraintsData, 'Graph');
        _showGraphFullScreen(getSineData(), 'Sine Wave');
        _showGraphFullScreen(getSquareWaveData(), 'Square Wave');
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid CSV data or format.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _getAxisNames() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Axis Names'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      xAxisName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'X-axis Name'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      yAxisName = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Y-axis Name'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<DataPoint> _parseCSVData(String csvString) {
    List<DataPoint> dataPoints = [];
    List<String> lines = csvString.split('\n');
    for (String line in lines) {
      List<String> values = line.split(',');
      if (values.length == 2) {
        double x = double.tryParse(values[0]) ?? 0.0;
        double y = double.tryParse(values[1]) ?? 0.0;
        dataPoints.add(DataPoint(x, y));
      }
    }
    return dataPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'IMPORT CSV AND PLOT GRAPH',
            style: TextStyle(
              color: Color(0xFF39FF14), // Text color
            ),
          ),
        ),
        backgroundColor: Colors
            .black, // Setting the background color of the AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              _inputConstraints();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent, // Transparent background
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF39FF14), // Border color
                  width: 3, // Border width
                ),
                //borderRadius: BorderRadius.circular(8), // Optional: Adds rounded corners to the border
                color: Colors.transparent, // Transparent background
              ),
              child: Text(
                'UPLOAD CSV AND PLOT GRAPH',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF39FF14), // Text color
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}