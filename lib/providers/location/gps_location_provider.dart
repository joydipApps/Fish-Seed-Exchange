import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final gpsLocationProvider =
    StateNotifierProvider<GpsLocationNotifier, Position?>((ref) {
  return GpsLocationNotifier();
});

class GpsLocationNotifier extends StateNotifier<Position?> {
  GpsLocationNotifier() : super(null); // Initialize with null

  void updateGpsLocation(Position newPosition) {
    state = newPosition; // Update the GPS location state
  }
}
