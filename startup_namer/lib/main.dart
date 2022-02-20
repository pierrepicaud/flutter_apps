// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  // ignore: prefer_const_constructors
  runApp(ChuckNorrisJokes());
}

// ignore: use_key_in_widget_constructors
class ChuckNorrisJokes extends StatefulWidget {
  @override
  _ChuckNorrisJokesState createState() => _ChuckNorrisJokesState();
}

class _ChuckNorrisJokesState extends State<ChuckNorrisJokes> {
  final url = "https://api.chucknorris.io/jokes/random";
  final categories = "https://api.chucknorris.io/jokes/categories";
  var _postsJson = {};
  var _categories = [];
  void fetchJoke() async {
    try {
      final response = await http.get(Uri.parse(url));
      final joke = jsonDecode(response.body) as Map;
      setState(() {
        _postsJson = joke;
      });
    } catch (err) {}
  }

  void fetchCatregories() async {
    try {
      final response = await http.get(Uri.parse(categories));
      final cat = jsonDecode(response.body) as List;
      setState(() {
        _categories = cat;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchJoke();
    fetchCatregories();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chuck Norris Jokes",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chuck Norris Jokes"),
        ),
        body: Center(
          child: Text(
            "${_postsJson["value"]}",
            style: const TextStyle(fontSize: 25),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                fetchJoke();
              });
            }),
      ),
    );
  }
}
