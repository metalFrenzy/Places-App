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
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 177, 173, 173),
                blurRadius: 5.0,
                offset: Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 5.0,
                offset: Offset(-5, 0),
              ),
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 5.0,
                offset: Offset(5, 0),
              ),
            ],
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImage == null
              ? const Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
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
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Current location',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectLocation,
              icon: const Icon(Icons.map),
              label: const Text(
                'Choose location :)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
