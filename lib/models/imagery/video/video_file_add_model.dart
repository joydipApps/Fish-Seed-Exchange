import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoFileAddModel {
  String saleId;
  String videoId;
  String userPhNo;
  File videoFile;

  VideoFileAddModel({
    required this.saleId,
    required this.videoId,
    required this.userPhNo,
    required this.videoFile,
  });

  factory VideoFileAddModel.fromJson(Map<String, dynamic> json) {
    return VideoFileAddModel(
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

class VideoFileAddModelNotifier extends StateNotifier<List<VideoFileAddModel>> {
  VideoFileAddModelNotifier() : super([]); // Initialize with an empty list

  void updateVideos(List<VideoFileAddModel> newVideos) {
    state = newVideos;
  }

  void addVideo(VideoFileAddModel newVideo) {
    state = [...state, newVideo]; // Add a single video to the list
  }

  void addAllVideos(List<VideoFileAddModel> newVideos) {
    state = [...state, ...newVideos]; // Add multiple videos to the list
  }
}
