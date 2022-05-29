import 'package:flutter/material.dart';
import 'package:flutter_app/components/auth/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../nav/navbar.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  dynamic user;

  String email;
  String pass;
  Future postdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/signin";

    dynamic dat = {"email": email, "password": pass};
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
                width: 50,
                height: 50,
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
                            fontWeight: FontWeight.bold),
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
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gethead(),
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
                    getregister(),
                  ])
            ])));
  }

  Widget getregister() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Don't have an account?",
              style: TextStyle(
                fontFamily: 'Oswald',
                color: Colors.black87,
                fontSize: 16,
              ),
            )));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Text("FUBOO",
            style: TextStyle(
              color: Colors.redAccent,
              fontFamily: 'Bebas',
              fontSize: 50,
            )));
  }

  Widget createbutton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50.0,
      child: RaisedButton(
        onPressed: () async {
          _showMyDialog();
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await postdata().then((value) => {
                if (value["message"] == "sigin successfully")
                  {
                    Navigator.of(context).pop(),
                    sharedPreferences.setString("userid", value["id"]),
                    sharedPreferences.setString("username", value["username"]),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  userid: value["id"],
                                  username: value["username"],
                                ))),
                  }
                else
                  {
                    Navigator.of(context).pop(),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          height: 25,
                          alignment: Alignment.center,
                          child: Text(value['message'],
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
              "Login",
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
