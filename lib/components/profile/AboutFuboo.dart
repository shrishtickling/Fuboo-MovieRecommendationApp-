import 'package:flutter/material.dart';

class Aboutme extends StatefulWidget {
  Aboutme({Key key}) : super(key: key);
  @override
  _AboutmeState createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {
  List about = [
    "",
    "Hey there! I'm Fuboo",
    "I've been created by a sophomore student from IITG named Shrishti",
    "I 💘 MOVIES!"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "ABOUT",
          style: TextStyle(
            fontFamily: 'Bebas',
            color: Colors.black87,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: about.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0)
                  return Container(
                      height: 150,
                      width: 100,
                      child: Image(
                        image: AssetImage("images/logo3.png"),
                      ));
                return Container(
                    margin: EdgeInsets.all(10),
                    child: Text("🎬  " + about[index],
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          color: Colors.black87,
                          fontSize: 18,
                        )));
              })),
    );
  }
}
