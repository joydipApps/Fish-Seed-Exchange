import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/location/location_remove_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> removeLocationData({
  required BuildContext context,
  required WidgetRef ref,
  required String locationId,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  // Obtain the location remove service instance from the provider
  final removeLocationService = ref.read(locationRemoveServiceProvider);

  try {
    // Call the removeLocationData method using the obtained service instance
    final apiResponse = await removeLocationService.removeLocationData(
        context, ref, locationId);

    // Update the state to indicate that location removal was successful
    ref
        .read(locationRemoveSuccessProvider.notifier)
        .setLocationRemoveSuccess(locationId, true);
    if (context.mounted) {
      showSnackDialog(context, 1, 'Record removal successful');
    }
  } catch (e) {
    if (context.mounted) {
      showSnackDialog(context, 2, 'An error occurred');
    }
  } finally {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
