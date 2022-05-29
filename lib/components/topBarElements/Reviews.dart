import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Reviews extends StatefulWidget {
  final id;
  final moviename;
  Reviews({Key key, @required this.id, this.moviename}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List reviews;
  void getpopularresponse() async {
    var response = await Dio()
        .get("http://movie-bj-9.herokuapp.com/getreview/" + widget.moviename);
    var data = response.data;
    try {
      if (mounted) {
        setState(() {
          reviews = data;
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
    if (reviews == null) return Center(child: CircularProgressIndicator());
    if (reviews.length == 0)
      return Center(
          child: Container(
              child: Text("No Reviews 🚫",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black54,
                      fontSize: 30))));
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          reviews[index]["review"],
                          maxLines: 12,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                            (reviews[index]['rating'] == "Good"
                                    ? "😊 "
                                    : "☹️ ") +
                                reviews[index]['rating'],
                            style: TextStyle(
                              fontFamily: 'Bebas',
                              fontSize: 25,
                              color: Colors.black87,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.8,
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
