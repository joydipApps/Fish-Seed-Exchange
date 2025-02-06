import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/enquiry/enquiry_update_provider.dart';
import '../../providers/enquiry/enquiry_view_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> enquiryUpdateData({
  required BuildContext context,
  required WidgetRef ref,
  required String enquiryId,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final enquiryNotifier = ref.read(enquiryViewModelProvider.notifier);
    final enquiryUpdateService = ref.read(enquiryUpdateServiceProvider);

    final apiResponse = await enquiryUpdateService.enquiryUpdateDetails(
      context: context,
      enquiryId: enquiryId,
    );

    if (apiResponse != null) {
      // Extract the enquiryId from the apiResponse
      enquiryNotifier.addEnquiries(apiResponse);

      // Display a success message
      // showSnackDialog(context, 1, 'Record Saving Successful');
    } else {
      // Display a failure message
      // showSnackDialog(context, 2, 'Record Saving Failure');
    }
  } catch (e) {
    // Handle any errors that might occur during the API call
    // showSnackDialog(context, 2, 'An error occurred: $e');
  } finally {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
