import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/video/video_file_view_model.dart';
import '../../../service/imagery/video_streaming/vido_file_view_service.dart';

final videoFileViewModelProvider =
    StateNotifierProvider<VideoFileViewModelNotifier, List<VideoFileViewModel>>(
        (ref) {
  return VideoFileViewModelNotifier();
});

final videoFileViewServiceProvider = Provider<VideoFileViewService>((ref) {
  return VideoFileViewService();
});

// return success id wise

final videoFileViewSuccessProvider =
    StateNotifierProviderFamily<VideoFileViewSuccessNotifier, bool, String>(
        (ref, saleId) {
  return VideoFileViewSuccessNotifier();
});

class VideoFileViewSuccessNotifier extends StateNotifier<bool> {
  VideoFileViewSuccessNotifier() : super(false); // Initialize with false

  void setVideoFileViewSuccess(bool value) {
    state = value;
  }
}
