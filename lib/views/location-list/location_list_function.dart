import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/location-list/location_list_model.dart';
import '../../providers/location-list/location_list_provider.dart';
import '../../utils/show_progress_dialog.dart';

Future<void> locationListFunction({
  required BuildContext context,
  required WidgetRef ref,
  required String phone_no,
}) async {
  debugPrint('locationListFunction called with phone_no: $phone_no');

  showProgressDialogSync(context); // Show loading indicator

  try {
    // Fetch location List data
    final bool success = ref.watch(locationListSuccessProvider);
    debugPrint(
        'locationListFunction: Initial locationListSuccessProvider value: $success');

    if (!success) {
      debugPrint(
          'locationListFunction:Fetching location data for phone_no: $phone_no');

      final List<LocationListModel>? locationData =
          await ref.read(locationListServiceProvider).listLocationData(
                context: context,
                phone_no: phone_no,
              );

      if (locationData != null && locationData.isNotEmpty) {
        debugPrint(
            'locationListFunction:Location data fetched successfully: ${locationData.length} records');

        ref
            .read(locationListModelProvider.notifier)
            .updateAddress(locationData);
        debugPrint(
            'locationListFunction:Locations added to locationListModelProvider: $locationData');

        ref
            .read(locationListSuccessProvider.notifier)
            .setLocationListSuccess(true);
        debugPrint(
            'locationListFunction:locationListSuccessProvider set to true');
      } else {
        debugPrint('locationListFunction:Location data is null or empty');
      }
    } else {
      debugPrint(
          'locationListFunction:Location list already fetched successfully');
    }
  } catch (e) {
    // Handle error
    debugPrint('locationListFunction:Error fetching location list: $e');
  } finally {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    debugPrint('locationListFunction:Dialog dismissed');
  }
}
