import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class TinderCard extends StatelessWidget {
  // const TinderCard({Key? key, this.color}) : super(key: key);

  final color;
  // final tweet;

  TinderCard({required this.color});

  @override
  Widget build(BuildContext context) {
    return Swipable(
      child: Container(
        color: color,
      ),
    );
  }
}
