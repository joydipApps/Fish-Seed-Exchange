import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/location/location_add_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';
import 'location_update_function.dart';

Future<void> locationAddData(
  BuildContext context,
  WidgetRef ref,
  locationSaveModel,
) async {
  showProgressDialogSync(context); // Show loading indicator

  // Obtain the location save service instance from the provider
  final locationAddService = ref.read(locationAddServiceProvider);

  try {
    // Call the locationSave method using the obtained service instance
    final apiResponse =
        await locationAddService.addLocationData(context, locationSaveModel);

    if (apiResponse != null) {
      // Update the state to indicate that location save was successful
      ref.read(locationAddSuccessProvider.notifier).setLocationAddSuccess(true);

      // Add the newly saved location to the list
      ref.read(locationAddModelProvider.notifier).addLocation(apiResponse);

      // Display a success message
      showSnackDialog(context, 1, 'Record Saving Successful');
      // Update the single location record for instant view in page
      String locationId = apiResponse.locationId;
      String phone = apiResponse.userPhoneNo;

      debugPrint("Service Response Data: $locationId");
      debugPrint("Service Response Data: $phone");

      await locationUpdateData(
        context: context,
        ref: ref,
        locationId: locationId,
      );
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
      Navigator.pop(context);
    }
  }
}
