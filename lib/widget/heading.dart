import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20),
      child: Column(
        children: [
          const Text(
            'Find a place,\n           and capture it',
            style: TextStyle(
              fontSize: 25,
              color: Colors.indigo,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
