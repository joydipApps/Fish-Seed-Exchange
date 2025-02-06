// import 'package:fishseeds/views/home/show_address_function.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../location/location_view_function.dart';
//
// Future<void> showLocationDialog(
//     BuildContext context, WidgetRef ref, String locationId) async {
//   try {
//     // Fetch the location data
//     await locationViewFunction(
//       context: context,
//       ref: ref,
//       req_type: 'location_id',
//       req_value: locationId,
//     );
//
//     // Show the address dialog
//     showAddressFunction(context, ref, locationId);
//   } catch (e) {
//     // Handle any errors that occur during fetching or showing dialog
//     print('Error: $e');
//   }
// }
//
// void onIconTapped(BuildContext context, WidgetRef ref, String locationId) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return FutureBuilder<void>(
//         future: showLocationDialog(context, ref, locationId),
//         builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Failed to load location data'),
//               actions: [
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           } else {
//             // The dialog for showing the address should have already been displayed
//             // if everything went well, so we can just return an empty container.
//             return Container();
//           }
//         },
//       );
//     },
//   );
// }
