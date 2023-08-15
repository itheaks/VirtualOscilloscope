import 'package:OSCILLO.EDGE/realtimecsv.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'createcsv.dart';
import 'importcsv.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to OSCILLO.EDGE',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(), // Use SplashScreen as the initial screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Create the animation
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);

    // Start the animation
    _animationController!.forward();

    // Wait for the animation to complete
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, navigate to the main UI screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyCreato()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF151420),
      body: Center(
        child: FadeTransition(
          opacity: _animation!,
          child:ClipOval(
            child: Image.asset(
              'assets/images/logo1.gif',
              width: 300,
              height: 300,
              fit:BoxFit.fitHeight
            ),
          )
        ),
      ),
    );
  }
}



class MyCreato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF39FF14),
      ),
      home: CarouselScreen(),
    );
  }
}

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final List<String> carouselItems = [
    "Import CSV",
    "Create CSV",
    "RealTime Data",
  ];

  final CarouselController _carouselController = CarouselController();

  void redirectFunction(String item) {
    // Add the navigation logic for different carousel items here
    // For example:

    switch (item) {
      case "Import CSV":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImportCsvScreen()),
        );
        break;
      case "Create CSV":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GraphScreen()),
        );
        break;
      case "RealTime Data":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RealTimeScreen()),
        );
        break;
      default:
        // Handle other cases or do nothing if needed
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
              "OSCILLO.EDGE",
              style: TextStyle(color: Color(0xFF39FF14)),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgg.jpg'),
            fit: BoxFit.cover, // You can adjust the BoxFit according to your needs
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Colors.white,
          //     Color(0xFF39FF14),
          //   ],
          // ),
        ),
      // body: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: [
      //         Colors.white,
      //         Color(0xFF39FF14),
      //       ],
      //     ),
      //   ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      "Created by Amit Kumar Singh",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF39FF14)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CarouselSlider(
                  items: carouselItems
                      .map(
                        (item) => GestureDetector(
                      onTap: () => redirectFunction(item),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xFF39FF14), // Color of the outline
                                width: 3, // Adjust the width of the outline
                              ),
                              color: Colors.transparent, // Set the background color to transparent
                            ),

                        //   child: Container(
                        // alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       Color(0xFF39FF14), // Use blue as the background color for carousel items
                        //       Color(0xFF39FF14).withOpacity(0.5),
                        //       Colors.black54, // Add saffron color to the gradient
                        //     ],
                        //     stops: [0.0, 0.7, 1.0], // Adjust the stops to control the blending of colors
                        //     begin: Alignment.topCenter,
                        //     end: Alignment.bottomCenter,
                        //   ),
                        // ),
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 20, color: Color(0xFF39FF14)),
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    initialPage: 0,
                  ),
                ),
                SizedBox(height: 350),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _carouselController.previousPage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Background color of the button
                        shape: CircleBorder(), // To create a circular button shape
                      ),
                      child: Transform.scale(
                        scale: 1.5, // Adjust the scale factor to increase size
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF39FF14), // Color of the arrow icon
                        ),
                      ),
                    ),
                    SizedBox(width: 200),
                    ElevatedButton(
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Background color of the button
                        shape: CircleBorder(), // To create a circular button shape
                      ),
                      child: Transform.scale(
                        scale: 1.8, // Adjust the scale factor to increase size
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF39FF14), // Color of the arrow icon
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
