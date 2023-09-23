import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Geocoding {
  static Future<String?> getCityName(double lat, double long) async {
    var res = await http.get(
      Uri.parse(
          'https://api.api-ninjas.com/v1/reversegeocoding?lat=$lat&lon=$long'),
      headers: {
        'X-Api-Key': 'H0KAnycmHqNBfK5rJioHPA==pmqyLF8hMAQkM42V',
      },
    );
    var data = json.decode(res.body);
    return data[0]['name'];
  }
}
