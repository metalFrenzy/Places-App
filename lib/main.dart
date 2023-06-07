import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places_provider.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/places_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesProv(),
      child: MaterialApp(
        title: 'Great Places ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Raleway',
          primarySwatch: Colors.indigo,
          canvasColor: Color.fromARGB(255, 212, 217, 237),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlace.routeName: (context) => AddPlace(),
          PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen()
        },
      ),
    );
  }
}
