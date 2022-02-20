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
  final categories = "https://api.chucknorris.io/jokes/categories";
  var _postsJson = {};
  var _categories = [];
  // ignore: prefer_final_fields
  late String _displayString;
  String valueChoose = "Select a category";

  void fetchJoke() async {
    try {
      final response = await http.get(Uri.parse(url));
      final joke = jsonDecode(response.body) as Map;
      setState(() {
        _postsJson = joke;
        makeDisplayString();
      });
      // ignore: empty_catches
    } catch (err) {}
  }

  void fetchCatregories() async {
    try {
      final response = await http.get(Uri.parse(categories));
      final cat = jsonDecode(response.body) as List;
      setState(() {
        _categories = cat;
      });
      // ignore: empty_catches
    } catch (err) {}
  }

  void fetchJokeWithCatregory() async {
    try {
      final urlWithCategory =
          "https://api.chucknorris.io/jokes/random?category=$valueChoose";
      final response = await http.get(Uri.parse(urlWithCategory));
      final joke = jsonDecode(response.body) as Map;
      setState(() {
        _postsJson = joke;
        makeDisplayString();
      });
      // ignore: empty_catches
    } catch (err) {}
  }

  void makeDisplayString() {
    final String str;
    if (valueChoose == "Select a category") {
      str = "${_postsJson["value"]}\n\nCategory: random";
    } else {
      str = "${_postsJson["value"]}\n\nCategory: $valueChoose";
    }
    setState(() {
      _displayString = str;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchJoke();
    fetchCatregories();
    makeDisplayString();
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  _displayString,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              tooltip: 'Get Random Jokes',
              child: const Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() {
                  fetchJoke();
                  valueChoose = "Select a category";
                });
              }),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            // ignore: avoid_unnecessary_containers
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton(
                hint: Text(valueChoose),
                dropdownColor: Colors.white,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: const SizedBox(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                onChanged: (newValue) {
                  setState(() {
                    valueChoose = newValue as String;
                    fetchJokeWithCatregory();
                  });
                },
                items: _categories.map((valueItem) {
                  return DropdownMenuItem(
                      value: valueItem, child: Text(valueItem));
                }).toList(),
              ),
            ),
          )),
    );
  }
}
