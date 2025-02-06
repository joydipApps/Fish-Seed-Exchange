import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/video/video_file_add_model.dart';
import '../../../service/imagery/video_streaming/video_file_add_Service.dart';

final videoFileAddModelProvider =
    StateNotifierProvider<VideoFileAddModelNotifier, List<VideoFileAddModel>>(
        (ref) {
  return VideoFileAddModelNotifier();
});

final videoFileAddServiceProvider = Provider<VideoFileAddService>((ref) {
  return VideoFileAddService();
});

// return success id wise

final videoFileAddSuccessProvider =
    StateNotifierProviderFamily<VideoFileAddSuccessNotifier, bool, String>(
        (ref, saleId) {
  return VideoFileAddSuccessNotifier();
});

class VideoFileAddSuccessNotifier extends StateNotifier<bool> {
  VideoFileAddSuccessNotifier() : super(false); // Initialize with false

  void setVideoFileAddSuccess(bool value) {
    state = value;
  }
}
