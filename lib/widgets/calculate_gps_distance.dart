import 'dart:math';

// Function to calculate distance between two GPS coordinates in kilometers
double calculateGpsDistance(
    double lat1, double lon1, double lat2, double lon2) {
  // Convert degrees to radians
  // p is the constant used to convert degrees to radians (p = π / 180).
  const p = 0.017453292519943295;

  // Calculate differences and convert to radians
  final dLat = (lat2 - lat1) * p;
  final dLon = (lon2 - lon1) * p;

  // Haversine formula
  final a = pow(sin(dLat / 2), 2) +
      cos(lat1 * p) * cos(lat2 * p) * pow(sin(dLon / 2), 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Earth's radius in kilometers
  const earthRadiusKm = 6371.0;

  // Calculate the distance
  final distanceKm = earthRadiusKm * c;

// Round to 2 decimal places and convert back to double
  final roundedDistanceKm = double.parse(distanceKm.toStringAsFixed(2));

  // Check if the distance is infinity or 0
  if (roundedDistanceKm.isNaN || roundedDistanceKm == 0) {
    return 0.0;
  }

  return roundedDistanceKm;
}
