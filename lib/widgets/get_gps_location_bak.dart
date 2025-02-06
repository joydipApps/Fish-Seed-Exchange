// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// Future<Position> getGpsLocation(BuildContext context) async {
//   debugPrint('Starting location retrieval process...');
//
//   // Check if location services are enabled
//   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   Position defaultPosition = Position(
//     latitude: 0.0,
//     longitude: 0.0,
//     timestamp: DateTime.now(),
//     accuracy: 0.0,
//     altitude: 0.0,
//     heading: 0.0,
//     speed: 0.0,
//     speedAccuracy: 0.0,
//     altitudeAccuracy: 0.0,
//     headingAccuracy: 0.0,
//   );
//
//   if (!serviceEnabled) {
//     // Prompt user to enable location services
//     debugPrint('Location services are disabled. Prompting user to enable...');
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Location Services Disabled"),
//           content: Text("Please enable location services to use this feature."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Open device location settings
//                 Geolocator.openLocationSettings();
//               },
//               child: Text("Enable"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//           ],
//         );
//       },
//     );
//     debugPrint('Returning default position (0.0, 0.0)');
//     return defaultPosition;
//   }
//
//   // Check location permissions
//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     // Request location permission
//     debugPrint('Location permission is denied. Requesting permission...');
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permission denied by user
//       debugPrint('Location permission denied by user.');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Location Permission Denied"),
//             content:
//                 Text("Please grant location permission to use this feature."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       debugPrint('Returning default position (0.0, 0.0)');
//       return defaultPosition;
//     }
//   }
//
//   try {
//     // Get current position
//     debugPrint('Fetching current location...');
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     debugPrint(
//         'Location retrieved successfully: ${position.latitude}, ${position.longitude}');
//     return position;
//   } catch (e) {
//     // Handle location retrieval errors
//     debugPrint('Failed to get location: $e');
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Error"),
//           content: Text("Failed to get location: $e"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//     debugPrint('Returning default position (0.0, 0.0)');
//     return defaultPosition;
//   }
// }
