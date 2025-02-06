//
//
// import 'package:fishseeds/models/imagery/picture/picture_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../providers/imagery/picture/picture_view_provider.dart';
// import '../../../utils/show_progress_dialog.dart';
// import '../../../utils/show_snack_dialog.dart';
//
// pictureViewFunction({
//   required BuildContext context,
//   required WidgetRef ref,
//   required PictureViewModel viewPicture,
// }) async {
//   showProgressDialogSync(context); // Show loading indicator
//
//   try {
//     final viewPictureService = ref.read(pictureViewServiceProvider);
//     final apiResponse = await viewPictureService.savePictureDetails(
//       context: context,
//       viewPicture: viewPicture,
//     );
//
//     if (apiResponse != null) {
//       if (context.mounted) {
//         showSnackDialog(context, 1, 'Record Saving Successful');
//       }
//     } else {
//       if (context.mounted) {
//         showSnackDialog(context, 2, 'Record Saving Failure');
//       }
//     }
//   } catch (e) {
//     debugPrint('Error occurred: $e');
//   } finally {
//     if (context.mounted) {
//       Navigator.pop(context);
//     } // Close the dialog
//   }
// }
