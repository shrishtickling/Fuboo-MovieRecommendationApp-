import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/components/home/Topbar.dart';
import 'package:shimmer/shimmer.dart';

class Homecorousel extends StatefulWidget {
  Homecorousel({Key key}) : super(key: key);

  @override
  _HomecorouselState createState() => _HomecorouselState();
}

class _HomecorouselState extends State<Homecorousel> {
  List val;
  Future getresponse() async {
    var response = await Dio().get(
        "https://api.themoviedb.org/3/trending/all/day?api_key=f0454bfc9c4b6944c00dca73888c08b1");
    var data = response.data;

    try {
      setState(() {
        val = data["results"];
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
    if (val == null)
      return Container(
          height: MediaQuery.of(context).size.height * 0.38,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: Colors.grey[500],
              direction: ShimmerDirection.ltr,
              highlightColor: Colors.grey[300],
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              )));
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height * 0.38,
        child: Carousel(
          autoplayDuration: Duration(seconds: 3),
          autoplay: true,
          images: [
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[1]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[1]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black87, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[1]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[2]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[2]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black87, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[2]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[3]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[3]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black87, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[3]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                    onTap: () async {
                      if (val[4]["original_title"] == null) {
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Topbar(
                                      moviename: val[4]["original_title"],
                                    )));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black87, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 30, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fitWidth,
                                image: "https://image.tmdb.org/t/p/original" +
                                    val[4]['poster_path'],
                                placeholder: "images/loading.png",
                              ))),
                    )),
              ],
            )
          ],
          dotSize: 4.0,
          dotSpacing: 15.0,
          dotColor: Colors.redAccent,
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.redAccent.withOpacity(0.0),
        ));
  }
}
