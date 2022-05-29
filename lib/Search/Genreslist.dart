import 'package:flutter/material.dart';
import 'package:flutter_app/Search/Genres.dart';

class Genreslist extends StatefulWidget {
  final userid;
  final username;
  final id;
  final genrename;
  Genreslist(
      {Key key, @required this.userid, this.id, this.username, this.genrename})
      : super(key: key);

  @override
  _GenreslistState createState() => _GenreslistState();
}

class _GenreslistState extends State<Genreslist> {
  String url =
      "https://api.themoviedb.org/3/discover/movie?api_key=f0454bfc9c4b6944c00dca73888c08b1&with_genres=";
  @override
  void initState() {
    super.initState();
    print(widget.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.genrename,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (1).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (2).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (3).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (4).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (6).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (7).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (8).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (9).toString(),
                genrename: widget.genrename,
              ),
              Genres(
                userid: widget.userid,
                username: widget.username,
                url: url + widget.id.toString() + "&page=" + (10).toString(),
                genrename: widget.genrename,
              )
            ],
          ),
        ));
  }
}
