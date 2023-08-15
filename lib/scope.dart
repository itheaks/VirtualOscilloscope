// // // import 'package:creatothon/realtimecsv.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:carousel_slider/carousel_slider.dart';
// // //
// // // import 'createcsv.dart';
// // // import 'importcsv.dart';
// // //
// // // void main() => runApp(MyApp());
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: CarouselScreen(),
// // //     );
// // //   }
// // // }
// // //
// // // class CarouselScreen extends StatefulWidget {
// // //   @override
// // //   _CarouselScreenState createState() => _CarouselScreenState();
// // // }
// // //
// // // class _CarouselScreenState extends State<CarouselScreen> {
// // //   final List<String> carouselItems = [
// // //     "Import CSV",
// // //     "Create CSV",
// // //     "RealTime Data",
// // //   ];
// // //
// // //   final CarouselController _carouselController = CarouselController();
// // //
// // //   void redirectFunction(String item) {
// // //     switch (item) {
// // //       case "Import CSV":
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(builder: (context) => CsvImportScreen()),
// // //         );
// // //         break;
// // //       case "Create CSV":
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(builder: (context) => GraphScreen()),
// // //         );
// // //         break;
// // //       case "RealTime Data":
// // //         Navigator.push(
// // //           context,
// // //           MaterialPageRoute(builder: (context) => RealTimeDataScreen()),
// // //         );
// // //         break;
// // //       default:
// // //       // Handle other cases or do nothing if needed
// // //         break;
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("Carousel with Arrow Buttons"),
// // //       ),
// // //       body: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: LinearGradient(
// // //             begin: Alignment.topCenter,
// // //             end: Alignment.bottomCenter,
// // //             colors: [Colors.white, Colors.blue],
// // //           ),
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Padding(
// // //               padding: EdgeInsets.all(32.0),
// // //               child: Text(
// // //                 "Welcome to this App Created by Amit and Muskan",
// // //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// // //               ),
// // //             ),
// // //             SizedBox(height: 20),
// // //             CarouselSlider(
// // //               items: carouselItems
// // //                   .map(
// // //                     (item) => GestureDetector(
// // //                   onTap: () => redirectFunction(item),
// // //                   child: Container(
// // //                     alignment: Alignment.center,
// // //                     color: Colors.blue,
// // //                     child: Text(
// // //                       item,
// // //                       style: TextStyle(fontSize: 20, color: Colors.white),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               )
// // //                   .toList(),
// // //               carouselController: _carouselController,
// // //               options: CarouselOptions(
// // //                 height: 300, // Updated height to 300
// // //                 enlargeCenterPage: true,
// // //                 viewportFraction: 0.8,
// // //                 initialPage: 0,
// // //               ),
// // //             ),
// // //             SizedBox(height: 20),
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     _carouselController.previousPage();
// // //                   },
// // //                   child: Icon(Icons.arrow_back),
// // //                 ),
// // //                 SizedBox(width: 20),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     _carouselController.nextPage();
// // //                   },
// // //                   child: Icon(Icons.arrow_forward),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // //
// // import 'dart:math';
// // import 'dart:convert';
// // import 'dart:typed_data';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:csv/csv.dart';
// //
// // void main() {
// //   runApp(OscilloscopeApp());
// // }
// //
// // class OscilloscopeApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Oscilloscope App',
// //       home: OscilloscopePage(),
// //     );
// //   }
// // }
// //
// // class OscilloscopePage extends StatefulWidget {
// //   @override
// //   _OscilloscopePageState createState() => _OscilloscopePageState();
// // }
// //
// // class _OscilloscopePageState extends State<OscilloscopePage> {
// //   List<List<dynamic>> csvData = [];
// //   List<double> xData = [];
// //   List<double> yData = [];
// //   bool isRealTime = false;
// //
// //   void generateData() {
// //     int dataPoints = 100;
// //     xData = List.generate(dataPoints, (index) => index.toDouble());
// //     yData = List.generate(dataPoints, (index) => sin(2 * pi * index / dataPoints));
// //   }
// //
// //   void createCSV() async {
// //     csvData.clear();
// //     csvData.add(['X-axis', 'Y-axis']);
// //     for (int i = 0; i < xData.length; i++) {
// //       csvData.add([xData[i], yData[i]]);
// //     }
// //
// //     String csv = const ListToCsvConverter().convert(csvData);
// //
// //     String fileName = "oscilloscope_data_${DateTime.now().millisecondsSinceEpoch}.csv";
// //     Uint8List csvBytes = Uint8List.fromList(utf8.encode(csv));
// //
// //     // Save the CSV file
// //     // (You can use a plugin like `file_saver` to save the file in the web version)
// //     // For demonstration purposes, we'll just display a toast message with the CSV content.
// //     String csvContent = utf8.decode(csvBytes);
// //     Fluttertoast.showToast(msg: csvContent);
// //   }
// //
// //   void uploadCSV() async {
// //     // Implement the file uploading functionality
// //     // Read the CSV file and update xData and yData lists accordingly
// //     // For demonstration purposes, we'll just display a toast message with the CSV content.
// //     Fluttertoast.showToast(msg: "File Upload functionality not implemented.");
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Oscilloscope App')),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: () {
// //                 generateData();
// //                 setState(() {});
// //               },
// //               child: Text('Generate Data'),
// //             ),
// //             ElevatedButton(
// //               onPressed: createCSV,
// //               child: Text('Create CSV File'),
// //             ),
// //             ElevatedButton(
// //               onPressed: uploadCSV,
// //               child: Text('Upload CSV File'),
// //             ),
// //             CheckboxListTile(
// //               title: Text('Real Time Data'),
// //               value: isRealTime,
// //               onChanged: (value) {
// //                 setState(() {
// //                   isRealTime = value!;
// //                 });
// //               },
// //             ),
// //             if (isRealTime) OscilloscopeGraph(xData: xData, yData: yData),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class OscilloscopeGraph extends StatelessWidget {
// //   final List<double> xData;
// //   final List<double> yData;
// //
// //   OscilloscopeGraph({required this.xData, required this.yData});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // Implement the graph visualization using xData and yData
// //     // You can use a chart library like `fl_chart` to display the graphs.
// //     // For demonstration purposes, we'll just display a placeholder text.
// //     return Container(
// //       margin: EdgeInsets.all(20),
// //       child: Text('Graph will be shown here.'),
// //     );
// //   }
// // }
//
//
// import 'package:creatothon/realtimecsv.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// import 'createcsv.dart';
// import 'importcsv.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CarouselScreen(),
//     );
//   }
// }
//
// class CarouselScreen extends StatefulWidget {
//   @override
//   _CarouselScreenState createState() => _CarouselScreenState();
// }
//
// class _CarouselScreenState extends State<CarouselScreen> {
//   final List<String> carouselItems = [
//     "Import CSV",
//     "Create CSV",
//     "RealTime Data",
//   ];
//
//   final CarouselController _carouselController = CarouselController();
//
//   void redirectFunction(String item) {
//     switch (item) {
//       case "Import CSV":
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ImportCsvScreen()),
//         );
//         break;
//       case "Create CSV":
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => GraphScreen()),
//         );
//         break;
//       case "RealTime Data":
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => RealTimeDataScreen()),
//         );
//         break;
//       default:
//       // Handle other cases or do nothing if needed
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Carousel with Arrow Buttons"),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.white, Colors.blue],
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(32.0),
//               child: Text(
//                 "Welcome to this App Created by Amit and Muskan",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 20),
//             CarouselSlider(
//               items: carouselItems
//                   .map(
//                     (item) => GestureDetector(
//                   onTap: () => redirectFunction(item),
//                   child: Container(
//                     alignment: Alignment.center,
//                     color: Colors.blue,
//                     child: Text(
//                       item,
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               )
//                   .toList(),
//               carouselController: _carouselController,
//               options: CarouselOptions(
//                 height: 300, // Updated height to 300
//                 enlargeCenterPage: true,
//                 viewportFraction: 0.8,
//                 initialPage: 0,
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _carouselController.previousPage();
//                   },
//                   child: Icon(Icons.arrow_back),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     _carouselController.nextPage();
//                   },
//                   child: Icon(Icons.arrow_forward),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
