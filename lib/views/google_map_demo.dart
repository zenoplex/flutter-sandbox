import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_sandbox/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class GoogleMapApp extends StatefulWidget {
  const GoogleMapApp({super.key});

  @override
  State<GoogleMapApp> createState() => _GoogleMapAppState();
}

class _GoogleMapAppState extends State<GoogleMapApp> {
  List<Marker> markers = [];
  late LatLng userLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        actions: [
          IconButton(
            onPressed: () async {
              final Map<String, dynamic> data = await findPlaces();
              setMarkers(data['places'] as List<dynamic>);
            },
            icon: const Icon(Icons.map),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getUserLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
          if (snapshot.hasData) {
            userLocation = snapshot.data!;
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: userLocation,
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
    // TODO: Should request permission and enable service before hand
    final PermissionStatus hasPermission = await location.hasPermission();
    final bool isServiceEnabled = await location.serviceEnabled();

    if (hasPermission == PermissionStatus.granted && isServiceEnabled) {
      // Note: In iOS simulator, custom location does not resolve getLocation.
      // @see https://stackoverflow.com/questions/24842594/ios-simulator-location-not-working
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

  // TODO: Should be moved out of widget
  Future<Map<String, dynamic>> findPlaces() async {
    final String apiKey = FlutterConfig.get('GOOGLE_MAP_API_KEY') as String;
    final Uri url =
        Uri.parse('https://places.googleapis.com/v1/places:searchNearby');
    final body = json.encode({
      "includedTypes": ["restaurant"],
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": userLocation.latitude,
            "longitude": userLocation.longitude,
          },
          "radius": 1000.0,
        },
      },
    });
    final response = await http.post(
      url,
      headers: {
        "X-Goog-Api-Key": apiKey,
        "X-Goog-FieldMask":
            "places.id,places.displayName,places.location,places.formattedAddress",
      },
      body: body,
    );

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final Map<String, dynamic> data =
          json.decode(response.body) as Map<String, dynamic>;
      return data;
    }
    throw Exception('Failed to fetch data');
  }

  void setMarkers(List<dynamic> places) {
    final List<Marker> newMarkers = places.map((data) {
      final Place place = Place.fromJson(data as Map<String, dynamic>);

      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(
          place.location.latitude,
          place.location.longitude,
        ),
        infoWindow: InfoWindow(
          title: place.displayName.text,
          snippet: place.formattedAddress,
        ),
      );
    }).toList();

    setState(() {
      markers = newMarkers;
    });
  }
}
