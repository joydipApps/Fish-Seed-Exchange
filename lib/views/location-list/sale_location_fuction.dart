import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/location-list/sale_location_model.dart';
import '../../providers/location-list/sale_location_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> saleLocationData({
  required BuildContext context,
  required WidgetRef ref,
  required SaleLocationModel saleData,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  // Obtain the location save service instance from the provider
  final saleLocationService = ref.read(saleLocationServiceProvider);

  try {
    // Call the locationSave method using the obtained service instance
    final apiResponse =
        await saleLocationService.addSaleLocationData(context, saleData);

    if (apiResponse != null) {
      // Update the state to indicate that location save was successful
      ref
          .read(saleLocationSuccessProvider.notifier)
          .setSaleLocationSuccess(true);

      // Add the newly saved location to the list
      ref.read(saleLocationModelProvider.notifier).addAddress(apiResponse);

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
