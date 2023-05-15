import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initLocation;
  final bool isSelecting;

  MapScreen(
      {this.initLocation =
          const PlaceLocation(latitude: 37.4221, longitude: -122.0841),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng coordinates) {
    setState(() {
      _pickedLocation = coordinates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.initLocation.latitude!,
                widget.initLocation.longitude!,
              ),
              zoom: 16),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickedLocation == null && widget.isSelecting
              ? {}
              : {
                  Marker(
                    markerId: MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(widget.initLocation.latitude!,
                            widget.initLocation.longitude!),
                  ),
                }),
    );
  }
}
