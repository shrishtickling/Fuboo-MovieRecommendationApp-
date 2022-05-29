import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  Error({Key key}) : super(key: key);

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
        backgroundColor: Colors.black87,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '404',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 50,
                    letterSpacing: 2,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'SORRY WE GOT SOME ERROR',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30,
                    color: Colors.redAccent),
              ),
            ],
          ),
        ));
  }
}
