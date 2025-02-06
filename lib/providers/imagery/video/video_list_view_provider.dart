import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/video/video_list_view_model.dart';
import '../../../service/imagery/video_streaming/video_list_view_service.dart';

final videoListViewModelProvider =
    StateNotifierProvider<VideoListViewModelNotifier, List<VideoListViewModel>>(
        (ref) {
  return VideoListViewModelNotifier();
});

final videoListViewServiceProvider = Provider<VideoListViewService>((ref) {
  return VideoListViewService();
});

// return success id wise

final videoListViewSuccessProvider =
    StateNotifierProviderFamily<VideoListViewSuccessNotifier, bool, String>(
        (ref, saleId) {
  return VideoListViewSuccessNotifier();
});

class VideoListViewSuccessNotifier extends StateNotifier<bool> {
  VideoListViewSuccessNotifier() : super(false); // Initialize with false

  void setVideoListViewSuccess(bool value) {
    state = value;
  }
}
