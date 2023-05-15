import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widget/image_input.dart';
import '../widget/location_input.dart';
import '../models/place.dart';
import '../providers/places_provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add';

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  late File? _pickedImage;
  final _form = GlobalKey<FormState>();
  var _place = Place(id: null, title: '', location: null, image: null);
  late PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _saveForm() {
    if (_place.title!.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Cannot add place'),
          content: Text('please add a photo to the place'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }
    _form.currentState!.save();
    Provider.of<PlacesProv>(context, listen: false)
        .addPlace(_place.title!, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add a new Place :)',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow:const  [
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
                            ]),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter the name of the Place !',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _place = Place(
                              id: null,
                              title: newValue,
                              location: _place.location,
                              image: _place.image,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ImageInput(_selectImage),
                     const  SizedBox(
                        height: 20,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Colors.orange,
            ),
            onPressed: _saveForm,
            icon: Icon(Icons.add),
            label: const Text(
              'Add the place',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
