import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enquiry/enquiry_view_model.dart';

import '../../providers/enquiry/enquiry_view_provider.dart';
import '../../utils/show_progress_dialog.dart';

Future<void> fetchEnquiryFunction(BuildContext context, WidgetRef ref) async {
  debugPrint('1. fetchEnquiryFunction called'); // Debug point 1

  showProgressDialogSync(context); // Show loading indicator

  try {
    // Fetch enquiry data
    debugPrint('2. Fetching enquiry data'); // Debug point 2
    final List<EnquiryViewModel>? enquiries = await ref
        .read(enquiryViewServiceProvider)
        .enquiryViewDetails(context: context);

    if (enquiries != null && enquiries.isNotEmpty) {
      // Update the provider with fetched data
      debugPrint('3. Updating enquiry view model provider'); // Debug point 3
      ref.read(enquiryViewModelProvider.notifier).setAllEnquiries(enquiries);
      // Set success flag to true
      debugPrint('4. Setting enquiry view success'); // Debug point 4
      ref.read(enquiryViewSuccessProvider.notifier).setEnquiryViewSuccess(true);
    }
  } catch (error) {
    // Handle error
    debugPrint('Error fetching enquiry data: $error');
  } finally {
    // Close loading indicator
    debugPrint('5. Closing loading indicator'); // Debug point 5
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
