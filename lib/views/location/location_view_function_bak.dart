// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../models/location/location_view_model.dart';
// import '../../providers/location/location_view_provider.dart';
// import '../../utils/show_progress_dialog.dart';
//
// Future<void> locationViewFunction({
//   required BuildContext context,
//   required WidgetRef ref,
//   required String req_type,
//   required String req_value,
// }) async {
//   showProgressDialogSync(context);
//   // Show loading indicator
//   // await showDialog(
//   //   context: context,
//   //   barrierDismissible: false,
//   //   builder: (context) => const Center(
//   //     child: CircularProgressIndicator(),
//   //   ),
//   // );
//
//   try {
//     // Fetch location view data
//     // Fetch the current success map from the provider
//     final successMap = ref.watch(locationViewSuccessProvider);
//
//     // Check if the locationId is in the map and its value
//     final bool success = successMap[req_value] ?? false;
//
//     if (!success) {
//       final LocationViewModel? locationData =
//       await ref.read(locationViewServiceProvider).viewLocationData(
//         context: context,
//         reqType: req_type,
//         reqValue: req_value,
//       );
//
//       if (locationData != null) {
//         final List<LocationViewModel> locations = [locationData];
//         ref.read(locationViewModelProvider.notifier).addAllLocations(locations);
//         // Update the success status for this location ID
//         ref
//             .read(locationViewSuccessProvider.notifier)
//             .setLocationViewSuccess(req_value, true);
//
//         // ref
//         //     .read(locationViewSuccessProvider.notifier)
//         //     .setLocationViewSuccess(req_value, true);
//       }
//     }
//   } catch (e) {
//     // Handle any errors that might occur during the async operation
//     debugPrint('An error occurred: $e');
//   } finally {
//     // Hide loading indicator
//     if (context.mounted) {
//       Navigator.of(context).pop();
//     }
//   }
// }
