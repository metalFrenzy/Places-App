import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEy = 'AIzaSyAxG_tXbRU1GKEDHI-Ep0jlDZe3ckFArAI';

class LocationService {
  static String locationImage({double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Alabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEy';
  }

  static Future<String> getAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEy');
    final res = await http.get(url);
    return json.decode(res.body)['results'][0]['formatted_address'];
  }
}
