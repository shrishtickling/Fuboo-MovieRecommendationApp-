import 'package:flutter/material.dart';
import 'package:flutter_app/components/auth/Login.dart';
import 'package:flutter_app/components/profile/AboutFuboo.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final id;
  final username;
  Profile({Key key, @required this.id, this.username}) : super(key: key);
  @override
  _profiletate createState() => _profiletate();
}

class _profiletate extends State<Profile> {
  launchurl() async {
    String url = "https://github.com/shrishtickling";
    if (await canLaunch(url) != null) {
      launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            height: 25,
            alignment: Alignment.center,
            child: Text("Trailer not found",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
          action: SnackBarAction(
            label: 'Cancel',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 1.5,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    gethead(),
                    InkWell(
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 25),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Icon(
                                      FontAwesome.download,
                                      color: Colors.black87,
                                      size: 25,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "Downloads",
                                    style: TextStyle(
                                      fontFamily: 'Bebas',
                                      color: Colors.black87,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ])),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, left: 25),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.black87,
                                    size: 25,
                                  )),
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  "BOOKMARKS",
                                  style: TextStyle(
                                    fontFamily: 'Bebas',
                                    color: Colors.black87,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ])),
                    InkWell(
                        onTap: () {
                          launchurl();
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(
                                        Icons.contact_page,
                                        color: Colors.black87,
                                        size: 25,
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "CONTACT",
                                      style: TextStyle(
                                        fontFamily: 'Bebas',
                                        color: Colors.black87,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ]))),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Aboutme()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Icon(
                                      FontAwesome.question_circle,
                                      color: Colors.black87,
                                      size: 25,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "ABOUT",
                                    style: TextStyle(
                                      fontFamily: 'Bebas',
                                      color: Colors.black87,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                    InkWell(
                        onTap: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove("userid");
                          sharedPreferences.remove("username");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(
                                        FontAwesome.sign_out,
                                        color: Colors.black87,
                                        size: 25,
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "SIGN OUT",
                                      style: TextStyle(
                                        fontFamily: 'Bebas',
                                        color: Colors.black87,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ])))
                  ]),
            )));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(
          top: 70,
        ),
        alignment: Alignment.center,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              alignment: Alignment.center,
              height: 120,
              width: 120,
              child: Text(
                widget.username[0],
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 35,
                  color: Colors.redAccent,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(120))),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              widget.username,
              style: TextStyle(
                fontFamily: 'Bebas',
                fontSize: 30,
                color: Colors.redAccent,
              ),
            ),
          ),
        ]));
  }
}
