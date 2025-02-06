import '../../providers/seed_sale/seed_sale_update_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/seed_sale/seed_sale_view_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> seedSaleUpdateData({
  required BuildContext context,
  required WidgetRef ref,
  required String saleId,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final seedSaleNotifier = ref.read(seedSaleViewModelProvider.notifier);
    final seedSaleUpdateService = ref.read(seedSaleUpdateServiceProvider);

    final apiResponse = await seedSaleUpdateService.updateSeedSaleDetails(
      context: context,
      saleId: saleId,
    );

    if (apiResponse != null) {
      // append apiResponse data to the existing leads data
      seedSaleNotifier.addAllSales(apiResponse);

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
    // Ensure the dialog is closed
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
