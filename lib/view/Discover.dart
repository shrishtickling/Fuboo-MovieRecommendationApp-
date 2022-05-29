import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/components/home/Topbar.dart';

class Discover extends StatefulWidget {
  final movieurlname;
  final originalmoviename;
  Discover({Key key, @required this.movieurlname, this.originalmoviename})
      : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  List popularlist;
  void getpopularresponse() async {
    var response = await Dio().get(
        "http://api.themoviedb.org/3/discover/movie?api_key=f0454bfc9c4b6944c00dca73888c08b1&primary_release_year=2010");
    var data = response.data;
    try {
      setState(() {
        popularlist = data["results"];
      });
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.originalmoviename,
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
      body: getallpopularmoviecard(),

      //AppB
    );
  }

  Widget getallpopularmoviecard() {
    if (popularlist == null)
      return Center(child: CircularProgressIndicator());
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
              itemCount: popularlist != null ? popularlist.length : 0,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Topbar(
                                            moviename: popularlist[index]
                                                ["original_title"],
                                          )));
                            },
                            child: Container(
                                height: 170,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: FadeInImage.assetNetwork(
                                    image: "https://image.tmdb.org/t/p/w500" +
                                        popularlist[index]["poster_path"],
                                    placeholder: "images/loading.png",
                                    fit: BoxFit.cover,
                                  ),
                                ))),
                        Positioned(
                            top: 3,
                            right: 0,
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )),
                      ],
                    ));
              }));
  }
}
