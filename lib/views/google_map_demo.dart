import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      body: const GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(35.652832, 139.839478), zoom: 12),
      ),
    );
  }
}
