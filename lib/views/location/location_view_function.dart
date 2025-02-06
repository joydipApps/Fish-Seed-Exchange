import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/location/location_view_model.dart';
import '../../providers/location/location_view_provider.dart';
import '../../utils/show_progress_dialog.dart';

Future<void> locationViewFunction({
  required BuildContext context,
  required WidgetRef ref,
  required String req_type,
  required String req_value,
}) async {
  debugPrint('locationViewFunction started');
  showProgressDialogSync(context);
  debugPrint('Progress dialog shown');

  try {
    debugPrint('Fetching location view data');
    // Fetch the current success map from the provider
    final successMap = ref.watch(locationViewSuccessProvider);
    debugPrint('Success map fetched: $successMap');

    // Check if the locationId is in the map and its value
    final bool success = successMap[req_value] ?? false;
    debugPrint('Success status for $req_value: $success');

    if (!success) {
      debugPrint('Location data not found, fetching new data');
      final LocationViewModel? locationData =
          await ref.read(locationViewServiceProvider).viewLocationData(
                context: context,
                reqType: req_type,
                reqValue: req_value,
              );
      debugPrint('Location data fetched: $locationData');

      if (locationData != null) {
        final List<LocationViewModel> locations = [locationData];
        ref.read(locationViewModelProvider.notifier).addAllLocations(locations);
        debugPrint('Locations added to provider: $locations');

        // Update the success status for this location ID
        ref
            .read(locationViewSuccessProvider.notifier)
            .setLocationViewSuccess(req_value, true);
        debugPrint('Success status updated for $req_value');
      } else {
        debugPrint('Location data is null');
      }
    } else {
      debugPrint('Location data already exists for $req_value, skipping fetch');
    }
  } catch (e) {
    debugPrint('An error occurred: $e');
  } finally {
    if (context.mounted) {
      Navigator.of(context).pop();
      debugPrint('Progress dialog dismissed');
    }
    debugPrint('locationViewFunction ended');
  }
}
