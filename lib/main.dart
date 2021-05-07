import 'package:famashi/screen/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FamashiApp());
}

class FamashiApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Famashi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
