import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/components/favorites/addFav.dart';
import 'package:flutter_app/components/home/Topbar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shimmer/shimmer.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Popularviewall extends StatefulWidget {
  final url;
  final userid;
  final username;
  Popularviewall({Key key, @required this.url, this.userid, this.username})
      : super(key: key);

  @override
  _PopularviewallState createState() => _PopularviewallState();
}

class _PopularviewallState extends State<Popularviewall> {
  List popularlist;
  Future<void> _showMyDialog(movieid, moviename, posterpath) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Container(
                height: 140,
                width: 140,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              AntDesign.hourglass,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                            Text(
                              "Add to Watchlist",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  color: Colors.redAccent),
                            ),
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

  void getpopularresponse() async {
    var response = await Dio().get(widget.url);

    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          popularlist = data["results"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getpopularresponse();
  }

  @override
  Widget build(BuildContext context) {
    return getallpopularmoviecard();
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Container(
          margin: EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (115.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 100,
              //controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  period: Duration(milliseconds: 2000),
                  baseColor: Colors.grey[700],
                  direction: ShimmerDirection.ltr,
                  highlightColor: Colors.grey[500],
                  child: Container(
                    height: 170,
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                );
              }));
    else
      return Container(
          margin: EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (115.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 18,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: popularlist[index]
                                                ["original_title"],
                                            userid: widget.userid,
                                            username: widget.username,
                                          )));
                            },
                            child: Container(
                                height: 170,
                                width: double.infinity,
                                child: popularlist[index]["poster_path"] == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage("images/loading.png"),
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: FadeInImage.assetNetwork(
                                          image:
                                              "https://image.tmdb.org/t/p/w500" +
                                                  popularlist[index]
                                                      ["poster_path"],
                                          placeholder: "images/loading.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ))),
                        Positioned(
                            top: 3,
                            right: 0,
                            child: InkWell(
                                onTap: () {
                                  _showMyDialog(
                                      popularlist[index]["id"],
                                      popularlist[index]["original"],
                                      popularlist[index]["poster_path"]);
                                },
                                child: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ))),
                      ],
                    ));
              }));
  }
}
