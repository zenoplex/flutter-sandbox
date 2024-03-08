import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _position = '';

  @override
  void initState() {
    super.initState();

    getPosition().then((position) {
      setState(() {
        _position =
            'Latitude: ${position!.latitude}, Longitude: ${position.longitude}';
      });
    });
  }

  Future<Position?> getPosition() async {
    await Geolocator.requestPermission();
    await Geolocator.isLocationServiceEnabled();
    // Simulate delay
    await Future.delayed(const Duration(seconds: 2));
    Position? position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  Widget build(BuildContext context) {
    final myWidget =
        _position == '' ? const CircularProgressIndicator() : Text(_position);
    return Scaffold(
      appBar: AppBar(title: const Text('GeoLocation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myWidget,
          ],
        ),
      ),
    );
  }
}
