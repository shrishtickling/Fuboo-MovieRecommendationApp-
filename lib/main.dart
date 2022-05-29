import 'package:flutter/material.dart';
import 'package:flutter_app/FubooScreen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuboo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
