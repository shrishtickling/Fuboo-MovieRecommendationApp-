import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/favorites/favoritesbar.dart';
import 'package:localstorage/localstorage.dart';
import 'Home.dart';
import 'Search.dart';
import 'Profile.dart';

class MyHomePage extends StatefulWidget {
  final List<Page> _pages = [
    Page('Home', Icons.home, 30),
    Page('search', Icons.search, 30),
    Page('library', Icons.favorite, 30),
    Page('profile', Icons.person_outline, 30),
  ];

  final userid;
  final username;
  MyHomePage({Key key, @required this.userid, this.username}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  Future getitemFromLocalStorage() async {
    try {
      var info = await json.decode(storage.getItem('user'));
      return info;
    } catch (e) {}
  }

  int _currentPageIndex = 0;

  void _openPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void initState() {
    super.initState();
    setState(() {
      _currentPageIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List routes = [
      Home(
        id: widget.userid,
        username: widget.username,
      ),
      Search(id: widget.userid, username: widget.username),
      Watchlistbar(id: widget.userid, username: widget.username),
      Profile(id: widget.userid, username: widget.username),
    ];
    return Scaffold(
      body: routes[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentPageIndex,
        items: widget._pages
            .map((Page page) => BottomNavigationBarItem(
                  icon: Icon(
                    page.iconData,
                    size: page.size,
                  ),
                  title: Text(page.title),
                ))
            .toList(),
        onTap: _openPage,
      ),
    );
  }
}

class Page {
  final String title;
  final IconData iconData;
  final double size;
  Page(this.title, this.iconData, this.size);
}
