import 'package:flutter/material.dart';
import 'package:flutter_app/components/favorites/addFav.dart';
import 'package:flutter_app/components/home/Topbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Latest extends StatefulWidget {
  final url;
  final id;
  final username;
  final recentname;
  Latest({Key key, @required this.url, this.id, this.username, this.recentname})
      : super(key: key);

  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  List val;
  List watchlist;
  bool add = false;
  Future getpostdata() async {
    if (widget.id == null) return;
    final String url =
        "https://fast-tor-93770.herokuapp.com/watch/" + widget.id;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
    } catch (e) {
      print(e);
    }
  }

  Future getresponse() async {
    var response = await Dio().get(widget.url);
    var data = response.data;
    try {
      if (widget.recentname != "") {
        if (mounted) {
          setState(() {
            val = data;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            val = data["results"];
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
    this.getpostdata().then((value) => {
          if (mounted)
            {
              if (value == null || value.length == 0)
                {
                  setState(() {
                    watchlist = value;
                  })
                }
              else
                {
                  setState(() {
                    watchlist = value[0]['watchlist'];
                  }),
                }
            }
        });
  }

  Future postdata(movieid, moviename, posterpath) async {
    final String url = "https://fast-tor-93770.herokuapp.com/saved/" +
        widget.id +
        "/" +
        movieid.toString();
    dynamic dat = {
      "userid": widget.id,
      "username": widget.username,
      "savedlist": [
        {
          "movieid": movieid.toString(),
          "moviename": moviename,
          "poster_path": posterpath
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
  }

  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
                height: 140,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Addwatchlist(
                                      userid: widget.id,
                                      username: widget.username,
                                      movieid: movieid,
                                      moviename: moviename,
                                      posterpath: posterpath)));
                        },
                        child: Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: Colors.redAccent,
                              size: 33,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 10),
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Add to Watchlist",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        ))),
                    InkWell(
                        onTap: () async {
                          await postdata(movieid, moviename, posterpath)
                              .then((val) => {
                                    Navigator.pop(context),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: Container(
                                          height: 25,
                                          alignment: Alignment.bottomLeft,
                                          child: Text("SAVED",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontFamily: 'Bebas',
                                                fontSize: 20,
                                              )),
                                        ),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {},
                                        ),
                                      ),
                                    )
                                  });
                        },
                        child: Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                              size: 32,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5, left: 10),
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Add to Favorites",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: Colors.redAccent),
                                )),
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
                              color: Colors.black87),
                        )))
                  ],
                ))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (val == null)
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 150.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(3.0)),
                );
              }));
    else
      return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 168.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: val.length != null ? val.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Topbar(
                                    moviename: val[index]["original_title"],
                                    userid: widget.id,
                                    username: widget.username,
                                  )));
                    },
                    child: Container(
                        width: 100,
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0)),
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                height: 150,
                                width: 100,
                                child: val[index]["poster_path"] == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image(
                                          image:
                                              AssetImage("images/loading.png"),
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: FadeInImage.assetNetwork(
                                          image:
                                              "https://image.tmdb.org/t/p/w500" +
                                                  val[index]["poster_path"],
                                          placeholder: "images/loading.png",
                                          fit: BoxFit.cover,
                                        ))),
                            Positioned(
                              top: 3,
                              right: 0,
                              child: GestureDetector(
                                  onTap: () {
                                    if (widget.id == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Container(
                                            height: 25,
                                            alignment: Alignment.center,
                                            child: Text("PLEASE LOGIN",
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                )),
                                          ),
                                          action: SnackBarAction(
                                            label: 'CANCEL',
                                            onPressed: () {
                                              // Code to execute.
                                            },
                                          ),
                                        ),
                                      );
                                    } else {
                                      _showMyDialog(
                                          val[index]["id"],
                                          val[index]["original_title"],
                                          val[index]["poster_path"]);
                                    }
                                  },
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )));
              }));
  }
}
