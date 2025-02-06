import '../../../models/imagery/picture/picture_add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/imagery/media/picture_count_provider.dart';
import '../../../providers/imagery/picture/picture_add_provider.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';

pictureAddFunction({
  required BuildContext context,
  required WidgetRef ref,
  required PictureAddModel addPicture,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final addPictureService = ref.read(pictureAddServiceProvider);
    final apiResponse = await addPictureService.savePictureDetails(
      context: context,
      addPicture: addPicture,
    );

    if (apiResponse != null) {
      ref
          .read(salePictureCounterProvider(addPicture.saleId).notifier)
          .increment();
      if (context.mounted) {
        showSnackDialog(context, 1, 'Record Saving Successful');
      }
    } else {
      if (context.mounted) {
        showSnackDialog(context, 2, 'Record Saving Failure');
      }
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
  } finally {
    if (context.mounted) {
      Navigator.pop(context);
    } // Close the dialog
  }
}
