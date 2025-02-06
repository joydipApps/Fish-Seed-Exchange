import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getGpsLocation(BuildContext context) async {
  debugPrint('GpsLocation: Starting location retrieval process...');

  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  debugPrint('GpsLocation: Location services enabled: $serviceEnabled');

  Position defaultPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );

  if (!serviceEnabled) {
    debugPrint(
        'GpsLocation: Location services are disabled. Prompting user to enable...');
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("GpsLocation: Location Services Disabled"),
          content: const Text(
              "GpsLocation: Please enable location services to use this feature."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
                debugPrint('GpsLocation:  Opening location settings...');
              },
              child: const Text("Enable"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
    debugPrint('GpsLocation: Returning default position (0.0, 0.0)');
    return defaultPosition;
  }

  // Check location permissions
  LocationPermission permission = await Geolocator.checkPermission();
  debugPrint('GpsLocation:  Initial location permission status: $permission');

  if (permission == LocationPermission.denied) {
    debugPrint(
        'GpsLocation:  Location permission is denied. Requesting permission...');
    permission = await Geolocator.requestPermission();
    debugPrint('GpsLocation:  New location permission status: $permission');

    if (permission == LocationPermission.denied) {
      debugPrint('GpsLocation:  Location permission denied by user.');
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("GpsLocation:  Location Permission Denied"),
            content: const Text(
                "GpsLocation:  Please grant location permission to use this feature."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      debugPrint('GpsLocation:  Returning default position (0.0, 0.0)');
      return defaultPosition;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    debugPrint('GpsLocation: Location permission denied forever.');
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Permission Denied Forever"),
          content: const Text(
              "Please go to settings and grant location permission to use this feature."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
                debugPrint('GpsLocation:  Opening app settings...');
              },
              child: const Text("Open Settings"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
    debugPrint('GpsLocation:  Returning default position (0.0, 0.0)');
    return defaultPosition;
  }

  try {
    debugPrint('GpsLocation:  Fetching current location...');
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    debugPrint(
        'GpsLocation:  Location retrieved successfully: ${position.latitude}, ${position.longitude}');
    return position;
  } catch (e) {
    debugPrint('GpsLocation:  Failed to get location: $e');
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to get location: $e"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    debugPrint('GpsLocation:  Returning default position (0.0, 0.0)');
    return defaultPosition;
  }
}
