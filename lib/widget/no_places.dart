import 'package:flutter/material.dart';

class NoPlaces extends StatelessWidget {
  const NoPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/loc.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        const Text(
          'No Places yet, start adding great places!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
