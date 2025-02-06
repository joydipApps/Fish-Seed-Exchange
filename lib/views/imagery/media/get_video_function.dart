import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/video/video_list_view_model.dart';
import '../../../providers/imagery/video/video_list_view_provider.dart';
import '../../../utils/show_progress_dialog.dart'; // Import your providers file

Future<void> fetchVideoViewData(
  BuildContext context,
  WidgetRef ref,
  String saleId,
  String userPhNo,
) async {
  showProgressDialogSync(context); // Show loading indicator

  // Fetch video view data
  final bool success = ref.watch(
    videoListViewSuccessProvider(saleId),
  );

  if (!success) {
    final List<VideoListViewModel>? videos = await ref
        .read(videoListViewServiceProvider)
        .getVideoList(context: context, saleId: saleId, userPhNo: userPhNo);

    if (videos != null && videos.isNotEmpty) {
      ref.read(videoListViewModelProvider.notifier).addAllVideos(videos);
      ref
          .read(videoListViewSuccessProvider(saleId).notifier)
          .setVideoListViewSuccess(true);
    }
  }

  if (context.mounted) {
    Navigator.of(context).pop();
  } // Close the dialog
}
