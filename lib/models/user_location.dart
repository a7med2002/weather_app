import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  double latitude = 0.0;
  double longitude = 0.0;

  UserLocation();

  Future<void> getUserLocation(BuildContext context) async {
    try {
      Position p;
      p = await getCurrentLocation();
      latitude = p.latitude;
      longitude = p.longitude;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Field Get Location: $e")));
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    return await Geolocator.getCurrentPosition();
  }
}
