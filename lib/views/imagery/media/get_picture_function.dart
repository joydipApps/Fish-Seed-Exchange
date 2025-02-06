import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/imagery/picture/picture_view_model.dart';
import '../../../providers/imagery/picture/picture_view_provider.dart';
import '../../../utils/show_progress_dialog.dart'; // Import your providers file

Future<void> fetchPictureViewData(
  BuildContext context,
  WidgetRef ref,
  String saleId,
) async {
  showProgressDialogSync(context); // Show loading indicator

  // Fetch picture view data
  final bool success = ref.watch(
    pictureViewSuccessProvider(saleId),
  );

  if (!success) {
    final List<PictureViewModel>? pictures = await ref
        .read(pictureViewServiceProvider)
        .getPictureDetails(context: context, saleId: saleId);

    if (pictures != null && pictures.isNotEmpty) {
      ref.read(pictureViewModelProvider.notifier).addAllPictures(pictures);
      ref
          .read(pictureViewSuccessProvider(saleId).notifier)
          .setPictureViewSuccess(true);
    }
  }

  if (context.mounted) {
    Navigator.of(context).pop();
  } // Close the dialog
}
