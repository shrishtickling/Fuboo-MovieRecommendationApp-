import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Createplaylist extends StatefulWidget {
  final userid;
  final username;
  Createplaylist({Key key, @required this.userid, this.username})
      : super(key: key);

  @override
  _CreateplaylistState createState() => _CreateplaylistState();
}

class _CreateplaylistState extends State<Createplaylist> {
  String create;
  Future postdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/watch";
    dynamic dat = {
      "userid": widget.userid,
      "username": widget.username,
      "watchlist": [
        {
          "watchlistname": create,
        }
      ]
    };

    try {
      await Dio().post(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
    } catch (e) {
      print(e);
    }
    setState(() {});
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
        backgroundColor: Color.fromRGBO(242, 94, 94, 2),
        body: Container(
            margin: EdgeInsets.only(top: 25),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.5, 0.5),
                colors: <Color>[
                  Color.fromRGBO(242, 94, 94, 2),
                  Color.fromRGBO(6, 0, 0, 2)
                ],
              ),
            ),
            child: Stack(children: [
              Positioned(
                left: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gethead(),
                    Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          bottom: 5,
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          onChanged: (text) {
                            setState(() {
                              create = text;
                            });
                          },
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'create'),
                        )),
                    createbutton(),
                  ])
            ])));
  }

  Widget gethead() {
    return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Text("New Watchlist",
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.bold)));
  }

  Widget createbutton() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          _showMyDialog();
          postdata().then((value) => {});
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Create",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.redAccent, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
