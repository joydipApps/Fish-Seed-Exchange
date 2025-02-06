import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoFileViewModel {
  String saleId;
  String videoId;
  String userPhNo;
  File videoFile;

  VideoFileViewModel({
    required this.saleId,
    required this.videoId,
    required this.userPhNo,
    required this.videoFile,
  });

  factory VideoFileViewModel.fromJson(Map<String, dynamic> json) {
    return VideoFileViewModel(
      saleId: json["sale_id"]?.toString() ?? '',
      videoId: json["video_id"]?.toString() ?? '',
      userPhNo: json["user_phno"]?.toString() ?? '',
      // Assuming json["file"] is a string path to the file
      videoFile: File(json["file"] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sale_id": saleId,
      "video_id": videoId,
      "user_phno": userPhNo,
      "file": videoFile.path, // Convert File to string path
    };
  }
}

class VideoFileViewModelNotifier
    extends StateNotifier<List<VideoFileViewModel>> {
  VideoFileViewModelNotifier() : super([]); // Initialize with an empty list

  void updateVideos(List<VideoFileViewModel> newVideos) {
    state = newVideos;
  }

  void ViewVideo(VideoFileViewModel newVideo) {
    state = [...state, newVideo]; // View a single video to the list
  }

  void ViewAllVideos(List<VideoFileViewModel> newVideos) {
    state = [...state, ...newVideos]; // View multiple videos to the list
  }
}
