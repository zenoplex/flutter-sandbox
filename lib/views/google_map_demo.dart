import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class GoogleMapApp extends StatefulWidget {
  const GoogleMapApp({super.key});

  @override
  State<GoogleMapApp> createState() => _GoogleMapAppState();
}

class _GoogleMapAppState extends State<GoogleMapApp> {
  final List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        actions: [
          IconButton(
            onPressed: () {
              findPlaces();
            },
            icon: const Icon(Icons.map),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getUserLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: snapshot.data!,
                zoom: 12,
              ),
              markers: Set.of(markers),
            );
          }

          return Container();
        },
      ),
    );
  }

  Future<LatLng?> getUserLocation() async {
    final Location location = Location();
    final PermissionStatus hasPermission = await location.hasPermission();
    final bool isServiceEnabled = await location.serviceEnabled();

    if (hasPermission == PermissionStatus.granted && isServiceEnabled) {
      final LocationData locationData = await location.getLocation();
      final double? latitude = locationData.latitude;
      final double? longitude = locationData.longitude;

      if (latitude == null || longitude == null) {
        return null;
      }
      return LatLng(latitude, longitude);
    }
    return null;
  }

  Future findPlaces() async {
    final String apiKey = FlutterConfig.get('GOOGLE_MAP_API_KEY') as String;
    final Uri url =
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby');
    final body = json.encode({
      "includedTypes": ["restaurant"],
      "locationRestriction": {
        "circle": {
          "center": {"latitude": 37.7937, "longitude": -122.3965},
          "radius": 500.0,
        },
      },
    });
    final response = await http.post(
      url,
      headers: {
        "X-Goog-Api-Key": apiKey,
        // TODO: Limit required data
        "X-Goog-FieldMask": "*",
      },
      body: body,
    );

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final data = json.decode(response.body);
      return data;
    }
    throw Exception('Failed to fetch data');
  }
}
