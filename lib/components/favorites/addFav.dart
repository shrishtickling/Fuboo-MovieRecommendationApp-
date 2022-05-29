import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Addwatchlist extends StatefulWidget {
  final userid;
  final username;
  final movieid;
  final moviename;
  final posterpath;
  Addwatchlist(
      {Key key,
      @required this.userid,
      this.username,
      this.movieid,
      this.moviename,
      this.posterpath})
      : super(key: key);

  @override
  _AddwatchlistState createState() => _AddwatchlistState();
}

class _AddwatchlistState extends State<Addwatchlist> {
  Future postdata(watchlistnameid) async {
    final String url = "https://fast-tor-93770.herokuapp.com/watch/" +
        widget.userid +
        "/" +
        watchlistnameid +
        "/" +
        widget.movieid.toString();
    dynamic dat = {
      "watchlistdata": [
        {
          "id": widget.movieid.toString(),
          "moviename": widget.moviename,
          "poster_path": widget.posterpath,
        }
      ]
    };

    try {
      await Dio().put(url,
          data: dat,
          options: Options(
              headers: {'Content-Type': 'application/json;charset=UTF-8'}));
    } catch (e) {
      print(e);
    }
  }

  List watchlist;
  Future getpostdata() async {
    final String url =
        "https://fast-tor-93770.herokuapp.com/watch/" + widget.userid;
    try {
      var response = await Dio().get(url);
      return response.data["post"];
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();

    this.getpostdata().then((value) => {
          if (mounted)
            {
              if (value.length == 0)
                {
                  setState(() {
                    watchlist = value;
                  })
                }
              else
                {
                  setState(() {
                    watchlist = value[0]['watchlist'];
                  }),
                }
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Add WATCH LIST",
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.redAccent,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: watchlist == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: watchlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          postdata(watchlist[index]['_id']).then((value) => {
                                Navigator.pop(context),
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Container(
                                      height: 25,
                                      alignment: Alignment.center,
                                      child: Text("Added to Watchlist",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    action: SnackBarAction(
                                      label: 'Cancel',
                                      onPressed: () {
                                        // Code to execute.
                                      },
                                    ),
                                  ),
                                )
                              });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 76,
                                  width: 76,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    image: AssetImage("images/logo3.png"),
                                  )),
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text(
                                        watchlist[index]['watchlistname'],
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent,
                                            fontSize: 19),
                                      )))
                            ],
                          ),
                        ));
                  })),
    );
  }
}
