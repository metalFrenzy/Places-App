import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/places_provider.dart';
import '../widget/place_list.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Plaaces :)'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PlacesProv>(context, listen: false).fetchSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlacesProv>(
                    child: Center(
                      child: Text('Got no places yet bruv'),
                    ),
                    builder: ((context, value, child) => value.items.length <= 0
                        ? child!
                        : ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: ((context, index) => PlaceList(
                                  value.items[index].title!,
                                  value.items[index].image!,
                                  value.items[index].id!,
                                  value.items[index].location!.address!
                                )),
                          )),
                  ),
      ),
    );
  }
}
