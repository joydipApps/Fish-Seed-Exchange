import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/leads/leads_update_provider.dart';
import '../../providers/leads/leads_view_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> leadsUpdateData({
  required BuildContext context,
  required WidgetRef ref,
  required String leadsId,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final leadsNotifier = ref.read(leadsViewModelProvider.notifier);
    final leadsUpdateService = ref.read(leadsUpdateServiceProvider);

    final apiResponse = await leadsUpdateService.leadsUpdateDetails(
      context: context,
      leadsId: leadsId,
    );

    if (apiResponse != null) {
      // append apiResponse data to the existing leads data
      leadsNotifier.addLeads(apiResponse);

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
      Navigator.pop(context);
    }
  }
}
