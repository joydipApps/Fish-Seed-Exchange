import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/leads/leads_add_model.dart';
import '../../providers/leads/leads_add_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';
import 'leads_update_function.dart';

leadsAddFunction(
  BuildContext context,
  WidgetRef ref,
  LeadsAddModel leadAddModel,
) async {
  debugPrint(
      'leadsAddFunction called with leadAddModel: ${leadAddModel.toString()}');

  showProgressDialogSync(context); // Show loading indicator

  try {
    final addLeadsService = ref.read(leadsAddServiceProvider);
    debugPrint('leadsAddFunction: addLeadsService obtained: $addLeadsService');

    final apiResponse =
        await addLeadsService.leadsAddData(context, leadAddModel);
    debugPrint('leadsAddFunction: API response received: $apiResponse');

    if (apiResponse != null) {
      if (context.mounted) {
        // showSnackDialog(context, 1, 'Record Saving Successful');
        debugPrint('leadsAddFunction: Record Saving Successful');

        String leadsId = apiResponse.leadsId;

        debugPrint('leadsAddFunction: leadsId : $leadsId');
        debugPrint('leadsAddFunction: leadsId : $leadsId');

        // Update the single enquiry record for instant view in page
        await leadsUpdateData(
          context: context,
          ref: ref,
          leadsId: leadsId,
        );
      }
    } else {
      if (context.mounted) {
        showSnackDialog(context, 2, 'Record Saving Failure');
        debugPrint('leadsAddFunction: Record Saving Failure');
      }
    }
  } catch (e) {
    debugPrint('leadsAddFunction: Error occurred: $e');
    if (context.mounted) {
      showSnackDialog(context, 2, 'Try Later');
    }
  } finally {
    if (context.mounted) {
      Navigator.pop(context);
    } // Close the dialog
    debugPrint('leadsAddFunction: Dialog closed');
  }
}
