// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

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
  late String valueChoose;
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
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "${_postsJson["value"]}",
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              tooltip: 'Get New Jokes',
              child: const Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() {
                  fetchJoke();
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
                hint: const Text("Select a category"),
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
