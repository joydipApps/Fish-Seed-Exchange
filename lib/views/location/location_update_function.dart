import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/location-list/location_list_provider.dart';
import '../../providers/location-list/location_list_update_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> locationUpdateData({
  required BuildContext context,
  required WidgetRef ref,
  required String locationId,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final locationNotifier = ref.read(locationListModelProvider.notifier);
    final locationUpdateService = ref.read(locationUpdateServiceProvider);

    final apiResponse = await locationUpdateService.updateLocationData(
      context: context,
      locationId: locationId,
    );

    if (apiResponse != null) {
      // Extract the locationId from the apiResponse
      locationNotifier.addAddress(apiResponse);

      // Display a success message
      //showSnackDialog(context, 1, 'Record Saving Successful');
    } else {
      // Display a failure message
      //showSnackDialog(context, 2, 'Record Saving Failure');
    }
  } catch (e) {
    // Handle any errors that might occur during the API call
    //showSnackDialog(context, 2, 'An error occurred: $e');
  } finally {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
