import 'package:flutter/material.dart';
import 'package:flutter_app/components/favorites/Saved.dart';
import 'package:flutter_app/nav/favorites.dart';

class Watchlistbar extends StatefulWidget {
  final id;
  final username;
  Watchlistbar({Key key, @required this.id, this.username}) : super(key: key);

  @override
  _WatchlistbarState createState() => _WatchlistbarState();
}

class _WatchlistbarState extends State<Watchlistbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.redAccent, width: 2.0),
                      ),
                    ),
                    tabs: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "WATCHLIST",
                            style: TextStyle(
                                fontFamily: 'Bebas',
                                color: Colors.black87,
                                fontSize: 20),
                          )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "FAVORITES",
                          style: TextStyle(
                              fontFamily: 'Bebas',
                              color: Colors.black87,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Watchlist(id: widget.id, username: widget.username),
            Saved(userid: widget.id, username: widget.username)
          ],
        ),
      ),
    );
  }
}
