import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/location-list/default_location_model.dart';
import '../../providers/location-list/default_location_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> defaultLocationData({
  required BuildContext context,
  required WidgetRef ref,
  required DefaultLocationModel defaultData,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  // Obtain the location save service instance from the provider
  final defaultLocationService = ref.read(defaultLocationServiceProvider);
  //final locationList = ref.watch(locationListModelProvider); // Watch the locationListModelProvider
  //final locationNotifier = ref.read(locationListModelProvider.notifier);

  try {
    // Call the locationSave method using the obtained service instance
    final apiResponse = await defaultLocationService.addDefaultLocationData(
        context, defaultData);

    if (apiResponse != null) {
      // Update the state to indicate that location save was successful
      ref
          .read(defaultLocationSuccessProvider.notifier)
          .setDefaultLocationSuccess(true);

      // Add the newly saved location to the list
      ref.read(defaultLocationModelProvider.notifier).addAddress(apiResponse);

      // set local provider
      // locationNotifier.setActiveLocation(defaultData.addressId);

      // Display a success message
      showSnackDialog(context, 1, 'Record Saving Successful');
    } else {
      // Display a failure message
      showSnackDialog(context, 2, 'Record Saving Failure');
    }
  } catch (e) {
    // Handle any errors that might occur during the API call
    showSnackDialog(context, 2, 'An error occurred: $e');
  } finally {
    // Ensure the dialog is closed
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
