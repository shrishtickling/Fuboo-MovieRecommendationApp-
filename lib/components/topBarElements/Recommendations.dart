import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/components/favorites/addFav.dart';
import 'package:flutter_app/components/home/Topbar.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Recommendations extends StatefulWidget {
  final id;
  final userid;
  final movie_name;
  final username;
  Recommendations(
      {Key key, @required this.id, this.movie_name, this.username, this.userid})
      : super(key: key);

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  List popularlist;
  List recommend;
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
                              AntDesign.heart,
                              color: Colors.redAccent,
                              size: 32,
                            ),
                            Text(
                              "Add to Favorites",
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
                              color: Colors.black87),
                        )))
                  ],
                ))),
          );
        });
  }

  void getpopularresponse() async {
    try {
      var response = await Dio().get("http://movie-bj-9.herokuapp.com/send/" +
          widget.movie_name.toString());
      var data = response.data;
      if (mounted) {
        setState(() {
          if (mounted) {
            popularlist = data;
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void getrecommend() async {
    try {
      var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
          widget.id.toString() +
          "/recommendations?api_key=f0454bfc9c4b6944c00dca73888c08b1&language=en-US&page=1");

      var data = response.data;
      if (mounted) {
        setState(() {
          recommend = data['results'];
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
    this.getrecommend();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: [getallpopularmoviecard()])));
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Container(
          margin: EdgeInsets.only(top: 3),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: 16,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 190,
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0)),
                );
              }));
    else
      return Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 5),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: (130.0 / 190.0),
              ),
              shrinkWrap: true,
              itemCount: popularlist != null ? popularlist.length : 0,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: popularlist[index]
                                                ["title"],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 190,
                              width: double.infinity,
                              child: popularlist[index]["poster_path"] == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('images/loading.png')))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: FadeInImage.assetNetwork(
                                        image:
                                            "https://image.tmdb.org/t/p/w500" +
                                                popularlist[index]
                                                    ["poster_path"],
                                        placeholder: "images/loading.png",
                                        fit: BoxFit.cover,
                                      )),
                            )),
                        Positioned(
                          top: 3,
                          right: 0,
                          child: InkWell(
                              onTap: () {
                                _showMyDialog(
                                  popularlist[index]["id"],
                                  popularlist[index]["original_title"],
                                  popularlist[index]["poster_path"],
                                );
                              },
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ));
              }));
  }
}
