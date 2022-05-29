import 'package:flutter/material.dart';
import '../Search/searchbar.dart';

class Search extends StatefulWidget {
  final id;
  final username;
  Search({Key key, @required this.id, this.username}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Searchbar(
        username: widget.username,
        id: widget.id,
      ),
    );
  }
}
