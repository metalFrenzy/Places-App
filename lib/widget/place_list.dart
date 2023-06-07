import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../providers/places_provider.dart';
import '../screens/places_details_screen.dart';

class PlaceList extends StatelessWidget {
  final String title;
  final File image;
  final String id;
  final String address;

  PlaceList(this.title, this.image, this.id, this.address);

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<PlacesProv>(context);
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          PlaceDetailsScreen.routeName,
          arguments: id,
        );
      },
      child: Container(
        height: deviceSize.height * 0.2,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 189, 200, 239),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: FileImage(image),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 24, 48, 184),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 24, 48, 184),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  place.removePlace(id);
                },
                icon: const Icon(
                  color: Color.fromARGB(255, 237, 20, 4),
                  Icons.delete_forever,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
