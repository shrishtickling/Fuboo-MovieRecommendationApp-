import 'package:flutter/material.dart';
import 'package:flutter_app/components/home/Error.dart';
import 'package:flutter_app/components/topBarElements/Recommendations.dart';
import 'package:flutter_app/components/topBarElements/Reviews.dart';
import 'package:flutter_app/components/favorites/addFav.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../topBarElements/About.dart';
import '../topBarElements/Cast.dart';
import 'package:dio/dio.dart';

class Topbar extends StatefulWidget {
  final moviename;
  final userid;
  final username;
  Topbar({Key key, @required this.moviename, this.userid, this.username})
      : super(key: key);

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  List moviedetails;

  launchurl() async {
    String url = "https://www.youtube.com/watch?v=" +
        moviedetails[1]["results"][0]["key"];
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
                )),
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

  void getpopularresponse() async {
    if (widget.moviename == null || widget.moviename == "") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Error()));
    }
    try {
      var response = await Dio().get(
          "http://movie-bj-9.herokuapp.com/getmovie/" +
              widget.moviename.toString());
      var data = response.data;
      setState(() {
        moviedetails = data;
      });
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Error()));
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      this.getpopularresponse();
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Error()));
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
                                      userid: widget.userid,
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
                                margin: EdgeInsets.only(top: 5, left: 10),
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Add to Bookmark",
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
            length: 4,
            child: moviedetails == null
                ? Center(child: CircularProgressIndicator())
                : NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          expandedHeight: 350,
                          pinned: true,
                          bottom: TabBar(
                            isScrollable: true,
                            indicatorWeight: 3,
                            indicator: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.black87, width: 2.0),
                              ),
                            ),
                            unselectedLabelColor: Colors.black87,
                            tabs: [
                              Tab(
                                child: Container(
                                  child: Text("About",
                                      style: TextStyle(
                                          fontFamily: 'Bebas',
                                          fontSize: 18,
                                          color: Colors.black87)),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text("Cast",
                                      style: TextStyle(
                                          fontFamily: 'Bebas',
                                          fontSize: 18,
                                          color: Colors.black87)),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text("Recommended",
                                      style: TextStyle(
                                          fontFamily: 'Bebas',
                                          fontSize: 18,
                                          color: Colors.black87)),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  child: Text("Reviews",
                                      style: TextStyle(
                                          fontFamily: 'Bebas',
                                          fontSize: 18,
                                          color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (moviedetails[0]['backdrop_path'] == null)
                                Container(
                                    width: double.infinity,
                                    height: 230,
                                    child: Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "images/loading.png",
                                        )))
                              else
                                ShaderMask(
                                  shaderCallback: (rect) {
                                    return LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.transparent
                                      ],
                                    ).createShader(Rect.fromLTRB(
                                        0, 30, rect.width, rect.height));
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: Image(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original" +
                                            moviedetails[0]['backdrop_path']),
                                    height: 230,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        widget.moviename,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontFamily: 'Bebas',
                                            fontSize: 30,
                                            decoration: TextDecoration.none,
                                            color: Colors.redAccent),
                                      )),
                                      Container(
                                          margin: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    launchurl();
                                                  },
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      margin: EdgeInsets.all(5),
                                                      width: 40,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      150),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom: 4,
                                                                      left: 5),
                                                              child: Icon(
                                                                  AntDesign
                                                                      .youtube,
                                                                  size: 22,
                                                                  color: Colors
                                                                      .redAccent)),
                                                        ],
                                                      ))),
                                            ],
                                          )),
                                      Container(
                                          child: Row(
                                        children: [
                                          Icon(
                                            FontAwesome.star,
                                            color: Colors.amber,
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(5),
                                            child: Text(
                                              moviedetails[0]['vote_average']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Bebas',
                                                  color: Colors.redAccent,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      )),
                                    ],
                                  )),
                            ],
                          ))),
                          actions: [
                            GestureDetector(
                                onTap: () {
                                  _showMyDialog(
                                      moviedetails[0]["id"],
                                      moviedetails[0]["original_title"],
                                      moviedetails[0]["poster_path"]);
                                },
                                child: Icon(Icons.more_vert)),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        About(
                            userid: widget.userid,
                            username: widget.username,
                            overview: moviedetails[0]['overview'],
                            moviename: moviedetails[0]['original_title'],
                            id: moviedetails[0]['id']),
                        Cast(
                          id: moviedetails[0]['id'],
                          userid: widget.userid,
                          username: widget.username,
                        ),
                        Recommendations(
                            userid: widget.userid,
                            id: moviedetails[0]['id'],
                            username: widget.username,
                            movie_name: widget.moviename),
                        Reviews(
                          id: moviedetails[0]['id'],
                          moviename: widget.moviename,
                        )
                      ],
                    ))));
  }
}
