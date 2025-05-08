import 'package:flutter/material.dart';
import '/screens/calculator_screen.dart';
//import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true; // Enable debug paint for layout debugging
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}
