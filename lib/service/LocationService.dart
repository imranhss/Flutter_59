

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_flutter/model/Location.dart';


class LocationService {

  final String baseUrl = "http://localhost:8080/api/location/";

  Future<List<Location>> getAllLocations() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Location.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print('Error fetching locations: $e');
      throw Exception('Error fetching locations; please try again later.');
    }
  }
}
