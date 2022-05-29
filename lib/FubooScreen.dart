import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/auth/Login.dart';
import 'package:flutter_app/nav/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String userid;
  String username;
  Future getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("userid");
    var name = sharedPreferences.getString("username");
    setState(() {
      userid = id;
      username = name;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getdata().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => userid == null
                    ? Login()
                    : MyHomePage(
                        userid: userid,
                        username: username,
                      )));
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
              child: Image(
        image: AssetImage("images/logo3.png"),
      ))),
    );
  }
}
