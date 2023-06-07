import 'package:flutter/material.dart';
import 'package:places_app/widget/heading.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/places_provider.dart';
import '../widget/place_list.dart';
import '../widget/no_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Heading(),
            FutureBuilder(
              future: Provider.of<PlacesProv>(context, listen: false)
                  .fetchSetPlaces(),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<PlacesProv>(
                      child: Center(
                        child: NoPlaces(),
                      ),
                      builder: ((context, value, child) =>
                          value.items.length <= 0
                              ? child!
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: value.items.length,
                                    itemBuilder: ((context, index) => PlaceList(
                                        value.items[index].title!,
                                        value.items[index].image!,
                                        value.items[index].id!,
                                        value.items[index].location!.address!)),
                                  ),
                                )),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.cyanAccent,
        label: const Text(
          'Add a place',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.lightBlue,
          ),
        ),
        icon: Icon(Icons.place),
        onPressed: () {
          Navigator.of(context).pushNamed(AddPlace.routeName);
        },
      ),
    );
  }
}
