import 'package:flutter/material.dart';
import 'package:personal_todo/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'Nunito')
        )
      ),
      home: HomePage(),
    );
  }
}