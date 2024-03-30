import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapApp extends StatefulWidget {
  const GoogleMapApp({super.key});

  @override
  State<GoogleMapApp> createState() => _GoogleMapAppState();
}

class _GoogleMapAppState extends State<GoogleMapApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: FutureBuilder(
        future: getUserLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: snapshot.data!,
                zoom: 12,
              ),
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
}
