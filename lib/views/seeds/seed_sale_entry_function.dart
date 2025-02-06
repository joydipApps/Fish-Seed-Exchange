import '../../models/seed_sale/seed_sale_add_model.dart';
import '../../views/seeds/seed_sale_update_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/seed_sale/seed_sale_insert_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

Future<void> seedSaleAddData({
  required BuildContext context,
  required WidgetRef ref,
  required SeedSaleAddModel seedSale,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  //send data through API.
  final seedSaleEntryService = ref.read(seedSaleAddServiceProvider);

  try {
    final apiResponse =
        await seedSaleEntryService.saveSeedSaleDetails(context, seedSale);

    if (apiResponse != null) {
      // TODO delete may be not required
      ref.read(seedSaleAddModelProvider.notifier).addSale(apiResponse);
      // ref
      //     .read(seedSaleInsertSuccessProvider.notifier)
      //     .setSeedSaleInsertSuccess(true);

      // send data through API.

      String saleId = apiResponse.saleId;

      // update view page
      await seedSaleUpdateData(context: context, ref: ref, saleId: saleId);
      if (context.mounted) {
        showSnackDialog(context, 1, 'Record Saved Successfully');
      }
    } else {
      if (context.mounted) {
        showSnackDialog(context, 2, 'Record Saving Failure');
      }
    }
  } catch (e) {
    if (context.mounted) {
      showSnackDialog(context, 2, 'An error occurred: $e');
    }
  } finally {
    // Ensure the dialog is closed
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
