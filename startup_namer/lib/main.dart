// ignore_for_file: unused_field

import 'dart:convert';
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
  final catgories = "https://api.chucknorris.io/jokes/categories";
  var _postsJson = {};
  void fetchJoke() async {
    try {
      final response = await http.get(Uri.parse(url));
      final joke = jsonDecode(response.body) as Map;
      setState(() {
        _postsJson = joke;
      });
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    fetchJoke();
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
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  final post = _postsJson;
                  return Text(
                    "${post["value"]}",
                    style: TextStyle(fontSize: 50),
                  );
                }),
          )),
    );
  }
}
