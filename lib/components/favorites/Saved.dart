import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/home/Topbar.dart';

class Saved extends StatefulWidget {
  final userid;
  final username;
  Saved({Key key, @required this.userid, this.username}) : super(key: key);

  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List savedlist;
  Future getpostdata() async {
    if (widget.userid == null) {
      return;
    }
    final String url =
        "https://fast-tor-93770.herokuapp.com/saved/" + widget.userid;
    try {
      var response = await Dio().get(url);
      return response.data['post'];
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    this.getpostdata().then((value) => {
          if (mounted)
            {
              if (value == null || value.length == 0)
                {
                  setState(() {
                    savedlist = [];
                  })
                }
              else
                {
                  if (mounted)
                    {
                      setState(() {
                        savedlist = value["savedlist"];
                      }),
                    }
                }
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        color: Colors.white,
        child: savedlist == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: (115.0 / 190.0),
                    ),
                    shrinkWrap: true,
                    itemCount: savedlist.length,
                    controller: ScrollController(keepScrollOffset: false),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Topbar(
                                      userid: widget.userid,
                                      username: widget.username,
                                      moviename: savedlist[index]
                                          ["moviename"])));
                        },
                        child: Container(
                            height: 170,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4.0),
                            margin: EdgeInsets.all(2),
                            child: savedlist[index]["poster_path"] == null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/loading.png"),
                                    ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage.assetNetwork(
                                      image:
                                          "https://image.tmdb.org/t/p/original" +
                                              savedlist[index]["poster_path"],
                                      placeholder: "images/loading.png",
                                      fit: BoxFit.cover,
                                    ))),
                      );
                    })));
  }
}
