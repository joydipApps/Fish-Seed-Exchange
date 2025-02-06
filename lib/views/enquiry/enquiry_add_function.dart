import '../../models/enquiry/enquiry_add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/enquiry/enquiry_add_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';
import 'enquiry_update_function.dart';

Future<void> enquiryAddData({
  required BuildContext context,
  required WidgetRef ref,
  required EnquiryAddModel enquiryData,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final enquiryAddService = ref.read(enquiryAddServiceProvider);

    final apiResponse =
        await enquiryAddService.enquiryAddData(context, enquiryData);

    if (apiResponse != null) {
      // Extract the enquiryId from the apiResponse
      String enquiryId = apiResponse.enquiryId;

      // Update the single enquiry record for instant view in page
      await enquiryUpdateData(context: context, ref: ref, enquiryId: enquiryId);
      if (context.mounted) {
        showSnackDialog(context, 1, 'Record Saving Successful');
      }
    } else {
      if (context.mounted) {
        showSnackDialog(context, 2, 'Record Saving Failure');
      }
    }
  } catch (e) {
    if (context.mounted) {
      showSnackDialog(context, 2, 'An error occurred');
    }
  } finally {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
