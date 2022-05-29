import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/Search/Genreslist.dart';
import 'package:flutter_app/Search/searchnames.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Searchbar extends StatefulWidget {
  final id;
  final username;
  Searchbar({Key key, @required this.id, this.username}) : super(key: key);
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  List val;
  List browse = [
    {"name": "Bollywood", "color": Colors.redAccent, "image": "images/doc.jpg"},
    {
      "name": "Hip Hop",
      "color": Colors.redAccent,
      "image": "images/mystery.jpg"
    },
    {
      "name": "Folk",
      "color": Colors.redAccent,
      "image": "images/animation.jpg"
    },
    {
      "name": "Hip Hop",
      "color": Colors.redAccent,
      "image": "images/comedy.jpg"
    },
    {"name": "top", "color": Colors.redAccent, "image": "images/crime.jpg"},
    {"name": "top", "color": Colors.redAccent, "image": "images/action.jpg"},
    {
      "name": "Bollywood",
      "color": Colors.redAccent,
      "image": "images/adventu.jpg"
    },
    {"name": "Folk", "color": Colors.redAccent, "image": "images/dram.jpg"},
    {
      "name": "Hip Hop",
      "color": Colors.redAccent,
      "image": "images/family.jpg"
    },
    {
      "name": "Hip Hop",
      "color": Colors.redAccent,
      "image": "images/fantasy.jpg"
    },
    {"name": "top", "color": Colors.redAccent, "image": "images/history.jpg"},
    {
      "name": "Bollywood",
      "color": Colors.redAccent,
      "image": "images/horror.jpg"
    },
    {"name": "Folk", "color": Colors.redAccent, "image": "images/music.jpg"},
    {"name": "top", "color": Colors.redAccent, "image": "images/romance.jpg"},
  ];
  Future getresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=f0454bfc9c4b6944c00dca73888c08b1&language=en-US");
    var data = response.data;
    try {
      setState(() {
        val = data["genres"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getresponse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          gethead(),
          getsearchbar(),
          //gettopgeneresname(),
          gettopgeneres(),
        ])));
  }

  Widget gethead() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(children: [
        Text("Search Movies🍿",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 20.0,
            )),
      ]),
    );
  }

  Widget gettopgeneresname() {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 0),
      child: Column(children: [
        Text("Top generes",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 20.0,
            ))
      ]),
    );
  }

  Widget getsearchbar() {
    return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(8.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black, width: 2.0)),
        child: TextField(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Searchnames(
                          userid: widget.id,
                          username: widget.username,
                        )));
          },
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
        ));
  }

  Widget gettopgeneres() {
    if (val == null)
      return Center(child: CircularProgressIndicator());
    else
      return Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (140.0 / 70.0),
              ),
              shrinkWrap: true,
              itemCount: 14,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Genreslist(
                                  id: val[index]['id'],
                                  genrename: val[index]['name'],
                                  userid: widget.id,
                                  username: widget.username)));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(3.0),
                        margin: EdgeInsets.all(3.3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image(
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                  colorBlendMode: BlendMode.modulate,
                                  fit: BoxFit.cover,
                                  image: AssetImage(browse[index]["image"]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(val[index]["name"],
                                  style: TextStyle(
                                    fontFamily: 'Bebas',
                                    fontSize: 25,
                                    color: Colors.grey[300],
                                  )),
                            )
                          ],
                        )));
              }));
  }
}
