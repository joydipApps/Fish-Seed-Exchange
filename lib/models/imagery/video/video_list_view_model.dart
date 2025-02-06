import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoListViewModel {
  String saleId;
  String videoId;
  String userPhNo;
  String pictureBase64;
  String videoUrl;

  VideoListViewModel({
    required this.saleId,
    required this.videoId,
    required this.userPhNo,
    required this.pictureBase64,
    required this.videoUrl,
  });

  factory VideoListViewModel.fromJson(Map<String, dynamic> json) {
    return VideoListViewModel(
      saleId: json["sale_id"]?.toString() ?? '',
      videoId: json["video_id"]?.toString() ?? '',
      userPhNo: json["user_phno"]?.toString() ?? '',
      pictureBase64: json["thumbnail_base64"]?.toString() ?? '',
      videoUrl: json["video_path"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sale_id": videoId,
      "video_id": videoId,
      "user_phno": userPhNo,
      "thumbnail_base64": pictureBase64,
      "video_path": videoUrl,
    };
  }
}

class VideoListViewModelNotifier
    extends StateNotifier<List<VideoListViewModel>> {
  VideoListViewModelNotifier() : super([]); // Initialize with an empty list

  void updateVideos(List<VideoListViewModel> newVideos) {
    state = newVideos;
  }

  void addVideo(VideoListViewModel newVideo) {
    state = [...state, newVideo]; // Add a single video to the list
  }

  void addAllVideos(List<VideoListViewModel> newVideos) {
    state = [...state, ...newVideos]; // Add multiple videos to the list
  }
}
