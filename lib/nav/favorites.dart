import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/favorites/favMovies.dart';
import 'package:dio/dio.dart';

class Watchlist extends StatefulWidget {
  final id;
  final username;
  Watchlist({Key key, @required this.username, this.id}) : super(key: key);
  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  List watchlist;
  String watchlistname;
  Future del(watchlistnameid) async {
    final String url = "https://fast-tor-93770.herokuapp.com/delete/" +
        widget.id +
        "/" +
        watchlistnameid;
    try {
      var response = await Dio().delete(url);
      return response.data["message"];
    } catch (e) {}
  }

  Future postdata() async {
    final String url = "https://fast-tor-93770.herokuapp.com/watch";
    dynamic dat = {
      "userid": widget.id,
      "username": widget.username,
      "timestamp": DateTime.now().toString(),
      "watchlist": [
        {
          "watchlistname": watchlistname,
        }
      ]
    };

    try {
      var response = await Dio().post(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
      return response.data["post"];
    } catch (e) {
      print(e);
    }
  }

  List random = [
    "images/gif1.gif",
    "images/gif3.webp",
    "images/gif4.gif",
    "images/gif5.gif",
    "images/gif6.gif",
    "images/gif7.webp",
    "images/gif8.gif",
    "images/gif9.webp",
    "images/gif10.webp"
  ];
  Future getpostdata() async {
    if (widget.id == null) {
      return;
    }
    final String url =
        "https://fast-tor-93770.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    this.getpostdata().then((value) => {
          if (value == null)
            {
              setState(() {
                watchlist = [];
              }),
            }
          else if (mounted)
            {
              setState(() {
                watchlist = value["post"];
              }),
            }
        });
  }

  Future<void> _showMyDialogs(watchlistnameid) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
                height: 100,
                width: 100,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () async {
                          del(watchlistnameid).then((result) => {
                                if (result == "success")
                                  {
                                    Navigator.pop(context),
                                    getpostdata().then((value) => {
                                          if (value == null)
                                            {
                                              setState(() {
                                                watchlist = [];
                                              }),
                                            }
                                          else if (mounted)
                                            {
                                              setState(() {
                                                watchlist = value["post"];
                                              }),
                                            }
                                        }),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text("Watchlist deleted",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        action: SnackBarAction(
                                          label: 'Cancel',
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  }
                                else
                                  {
                                    Navigator.pop(context),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text("Got some Error",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        action: SnackBarAction(
                                          label: 'Cancel',
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  }
                              });
                        },
                        child: Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 33,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "DELETE WATCHLIST",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        ))),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: Text(
                          "CLOSE",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )))
                  ],
                ))),
          );
        });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: TextField(
                      maxLines: 1,
                      minLines: 1,
                      onChanged: (text) {
                        setState(() {
                          watchlistname = text;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Create Watchlist'),
                    ))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ADD',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                if (watchlistname == null || watchlistname == "") {
                } else {
                  await postdata().then((value) => {
                        setState(() {
                          getpostdata().then((value) => {
                                if (mounted)
                                  {
                                    setState(() {
                                      watchlist = value["post"];
                                    }),
                                  }
                              });
                        }),
                        Navigator.pop(context)
                      });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    height: 25,
                    alignment: Alignment.center,
                    child: Text("PLEASE LOGIN",
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
            } else
              _showMyDialog();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
        body: watchlist == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                    itemCount: watchlist.length == 0
                        ? 0
                        : watchlist[0]["watchlist"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => favMovies(
                                        username: widget.username,
                                        userid: widget.id,
                                        watchlistname: watchlist[0]["watchlist"]
                                            [index]['watchlistname'],
                                        watchlistmovieid: watchlist[0]
                                            ["watchlist"][index]['_id'])));
                          },
                          child: Container(
                              height: 159,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                        colorBlendMode: BlendMode.modulate,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        image: AssetImage(random[
                                            Random().nextInt(random.length)])),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 0,
                                      child: InkWell(
                                          onTap: () {
                                            _showMyDialogs(watchlist[0]
                                                ["watchlist"][index]['_id']);
                                          },
                                          child: Icon(Icons.more_vert,
                                              color: Colors.white))),
                                  Positioned(
                                      bottom: 10,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                            watchlist[0]["watchlist"][index]
                                                        ["watchlistname"] ==
                                                    null
                                                ? ""
                                                : watchlist[0]["watchlist"]
                                                    [index]["watchlistname"],
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      )),
                                ],
                              )));
                    }),
              ));
  }
}
