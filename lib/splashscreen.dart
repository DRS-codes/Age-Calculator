import 'package:age_calculator/homepage.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  double boxheight = 100;
  double boxwidth = 100;
  double radius = 150;
  double fontsize = 10;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        boxheight = 1500;
        boxwidth = 1500;
        radius = 0;
        fontsize = 40;
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgeCalculatorApp(),
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          height: boxheight,
          width: boxwidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: const Color.fromARGB(255, 94, 0, 122),
          ),
          duration: Duration(seconds: 2),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Age\nCalculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontsize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
