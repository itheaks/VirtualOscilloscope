import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RealTimeScreen(),
    );
  }
}

class RealTimeScreen extends StatefulWidget {
  @override
  _RealTimeScreenState createState() => _RealTimeScreenState();
}

class _RealTimeScreenState extends State<RealTimeScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothCharacteristic? _characteristic;
  List<FlSpot> _dataPoints = [];

  @override
  void initState() {
    super.initState();
    _setupBluetooth();
  }
  void _setupBluetooth() async {
    flutterBlue.scanResults.listen((results) async {
      for (ScanResult result in results) {
        if (result.device.name == "YourArduinoDeviceName") {
          BluetoothDevice device = result.device;
          await device.connect();

          List<BluetoothService> services = await device.discoverServices();
          for (BluetoothService service in services) {
            for (BluetoothCharacteristic characteristic in service.characteristics) {
              if (characteristic.uuid == Uuid.parse("uuid")) {
                _characteristic = characteristic;
                _characteristic!.setNotifyValue(true);
                _characteristic!.value.listen((value) {
                  String response = String.fromCharCodes(value);
                  _updateGraph(response);
                });
                break;
              }
            }
          }
          break;
        }
      }
    });
    flutterBlue.startScan();
  }


  void _updateGraph(String response) {
    if (response == "LED ON") {
      _dataPoints.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), 1));
    } else if (response == "LED OFF") {
      _dataPoints.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), 0));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oscilloscope Graph'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backlol.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  minX: _dataPoints.isNotEmpty
                      ? _dataPoints.first.x
                      : DateTime.now().subtract(Duration(seconds: 10)).millisecondsSinceEpoch.toDouble(),
                  maxX: _dataPoints.isNotEmpty
                      ? _dataPoints.last.x
                      : DateTime.now().millisecondsSinceEpoch.toDouble(),
                  minY: 0,
                  maxY: 1,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _dataPoints,
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
