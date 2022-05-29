import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/home/Topbar.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class Swiper extends StatefulWidget {
  final userid;
  final username;

  Swiper({Key key, @required this.userid, this.username}) : super(key: key);

  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  List val;
  Future postdata(movieid, moviename, posterpath) async {
    final String url = "https://fast-tor-93770.herokuapp.com/saved/" +
        widget.userid +
        "/" +
        movieid.toString();
    dynamic dat = {
      "userid": widget.userid,
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

  Future getresponse() async {
    var response = await Dio().get("https://movie-bj-9.herokuapp.com/getswipe");
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          val = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
  }

  bool right = false;
  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Container(
                height: 120,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          postdata(movieid, moviename, posterpath)
                              .then((val) => {
                                    Navigator.pop(context),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text("SAVED",
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
                                  });
                        },
                        child: Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.bookmark,
                              color: Colors.redAccent,
                              size: 32,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 20),
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
                          setState(() {
                            right = false;
                          });
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

  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "SWIPE RIGHT OR LEFT",
          style: TextStyle(
              fontFamily: 'Bebas', color: Colors.black87, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: val == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              alignment: Alignment.center,
              height: double.infinity,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.only(bottom: 20),
              child: new TinderSwapCard(
                orientation: AmassOrientation.BOTTOM,
                totalNum: val.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 1.0,
                maxHeight: MediaQuery.of(context).size.width * 1.85,
                minWidth: MediaQuery.of(context).size.width * 0.83,
                minHeight: MediaQuery.of(context).size.width * 1,
                cardBuilder: (context, index) => Card(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Topbar(
                                      userid: widget.userid,
                                      username: widget.username,
                                      moviename: val[index]
                                          ['original_title'])));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: FadeInImage.assetNetwork(
                                  image: "https://image.tmdb.org/t/p/original" +
                                      val[index]["poster_path"],
                                  placeholder: "images/loading.png",
                                  fit: BoxFit.cover,
                                ))))),
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  if (align.x < 0) {
                  } else if (align.x > 3) {
                    setState(() {
                      right = true;
                    });
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  if (right) {
                    _showMyDialog(
                        val[index]["id"],
                        val[index]["original_title"],
                        val[index]["poster_path"]);
                  }
                },
              ),
            ),
    );
  }
}
