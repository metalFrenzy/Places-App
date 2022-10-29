import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/location_service.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;
  LocationInput(this.selectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImage;

  void _showPreview(double lat, double lng) {
    final staticMapPreview = LocationService.locationImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImage = staticMapPreview;
    });
  }

  Future<void> _getLocation() async {
    final coordinates = await Location().getLocation();
    _showPreview(coordinates.latitude!, coordinates.longitude!);
    widget.selectPlace(coordinates.latitude, coordinates.longitude);
  }

  Future<void> _selectLocation() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: ((context) => MapScreen(
              isSelecting: true,
            )),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImage == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
            ),
            TextButton.icon(
              onPressed: _selectLocation,
              icon: Icon(Icons.map),
              label: Text('Choose location :)'),
            ),
          ],
        )
      ],
    );
  }
}
