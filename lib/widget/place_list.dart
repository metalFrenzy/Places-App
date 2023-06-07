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
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
      ),
      onDismissed: ((direction) {
        place.removePlace(id);
      }),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        elevation: 3.0,
        shadowColor: Color.fromARGB(255, 0, 119, 255),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(image),
            ),
            title: Text(
              title,
            ),
            subtitle: Text(address),
            onTap: () {
              Navigator.of(context).pushNamed(
                PlaceDetailsScreen.routeName,
                arguments: id,
              );
            },
          ),
        ),
      ),
    );
  }
}
