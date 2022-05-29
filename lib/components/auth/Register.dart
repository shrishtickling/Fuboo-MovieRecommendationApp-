import 'package:flutter/material.dart';
import 'package:flutter_app/components/auth/Login.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/nav/navbar.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username;
  String email;
  String pass;

  Future postdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/signup";
    dynamic dat = {"username": username, "email": email, "password": pass};
    try {
      var response = await Dio().post(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));

      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                child: Center(
                    child: Row(
              children: [
                CircularProgressIndicator(),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(children: [
              Positioned(
                  left: 10,
                  child: Container(
                    margin: EdgeInsets.only(top: 24),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  )),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gethead(),
                    getusername(),
                    Container(
                        height: 80,
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 2,
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              email = text;
                            });
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black87),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        )),
                    Container(
                        height: 80,
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 2,
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              pass = text;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.black87),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        )),
                    createbutton(),
                  ])
            ])));
  }

  Widget getusername() {
    return Container(
        height: 80,
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: 2,
        ),
        width: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextField(
          onChanged: (text) {
            setState(() {
              username = text;
            });
          },
          decoration: InputDecoration(
              labelText: 'Username',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.redAccent),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black87),
                borderRadius: BorderRadius.circular(5),
              )),
        ));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Text("Registration",
            style: TextStyle(
              fontFamily: 'Bebas',
              color: Colors.black87,
              fontSize: 30,
            )));
  }

  Widget createbutton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50.0,
      child: RaisedButton(
        onPressed: () async {
          _showMyDialog();
          await postdata().then((value) => {
                if (value["message"] == "registered successfully")
                  {
                    Navigator.of(context).pop(),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()))
                  }
                else
                  {
                    Navigator.of(context).pop(),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(value["message"],
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
                    )
                  }
              });
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Sign up",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Bebas', color: Colors.black87, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
