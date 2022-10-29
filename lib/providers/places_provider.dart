import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/place.dart';
import '../services/places_db.dart';
import '../services/location_service.dart';

class PlacesProv with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationService.getAddress(
        pickedLocation.latitude!, pickedLocation.longitude!);
    final location = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: location,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image!.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address
    });
  }

  Future<void> fetchSetPlaces() async {
    final data = await DBHelper.getData('user_places');
    _items = data
        .map(
          (i) => Place(
            id: i['id'],
            title: i['title'],
            location: PlaceLocation(
              latitude: i['loc_lat'],
              longitude: i['loc_lng'],
              address: i['address'],
            ),
            image: File(
              i['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  void removePlace(String placeID) {
    _items.remove(placeID);
    notifyListeners();
    DBHelper.deleteData('user_places', placeID);
  }
}
