import 'package:flutter/material.dart';
import 'package:flutter_app/view/popularviewall.dart';

class Popularviewlist extends StatefulWidget {
  final originalmoviename;
  final url;
  final userid;
  final username;
  Popularviewlist(
      {Key key,
      @required this.originalmoviename,
      this.url,
      this.userid,
      this.username})
      : super(key: key);

  @override
  _PopularviewlistState createState() => _PopularviewlistState();
}

class _PopularviewlistState extends State<Popularviewlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            widget.originalmoviename,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Popularviewall(
                url: widget.url + "&page=" + (1).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (2).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (3).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (4).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (5).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (6).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (8).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (9).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
              Popularviewall(
                url: widget.url + "&page=" + (10).toString(),
                userid: widget.userid,
                username: widget.username,
              ),
            ],
          ),
        ));
  }

  Widget getlist() {
    return ListView.builder(
        itemCount: 5,
        primary: true,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Popularviewall(
            url: widget.url + "&page=" + (index + 1).toString(),
            userid: widget.userid,
            username: widget.username,
          );
        });
  }
}
