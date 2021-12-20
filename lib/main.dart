import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xff97BFB4),
        ),
      ),
      home: Calculator(),
    );
  }
}
