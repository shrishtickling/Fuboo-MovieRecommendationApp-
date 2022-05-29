import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';

class Cast extends StatefulWidget {
  final id;
  final userid;
  final username;
  Cast({Key key, @required this.id, this.userid, this.username})
      : super(key: key);

  @override
  _CastState createState() => _CastState();
}

class _CastState extends State<Cast> {
  List cast;

  void getpopularresponse() async {
    var response = await Dio().get("https://api.themoviedb.org/3/movie/" +
        widget.id.toString() +
        "/credits?api_key=f0454bfc9c4b6944c00dca73888c08b1&language=en-US");
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          cast = data["cast"];
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

  Widget build(BuildContext context) {
    if (cast == null)
      return Container(
          height: 50.0,
          margin: EdgeInsets.only(top: 10, left: 20),
          width: double.infinity,
          child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                    period: Duration(milliseconds: 2000),
                    baseColor: Colors.grey[700],
                    direction: ShimmerDirection.ltr,
                    highlightColor: Colors.grey[500],
                    child: Container(
                        child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(60)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, right: 10),
                          padding: EdgeInsets.only(left: 20, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 40,
                          color: Colors.grey,
                        ),
                      ],
                    )));
              }));
    return Container();
  }

  Widget gethead(cast, index) {
    return Container(
        child: Row(children: [
      CircleAvatar(
        radius: 32,
        backgroundColor: Colors.black12,
        backgroundImage: NetworkImage(cast[index]["profile_path"] == null
            ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR28i5jWF37DvM01csPLTUTxEvCUAiL1ho6qw&usqp=CAU"
            : "https://image.tmdb.org/t/p/w500" + cast[index]["profile_path"]),
      ),
      Expanded(
          child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20, bottom: 10),
        child: Text(
          cast[index]["name"],
          style: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              decoration: TextDecoration.none),
        ),
      )),
    ]));
  }
}
