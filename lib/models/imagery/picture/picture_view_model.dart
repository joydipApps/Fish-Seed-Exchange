import 'package:flutter_riverpod/flutter_riverpod.dart';

class PictureViewModel {
  String saleId;
  String pictureId;
  String userPhNo;
  String pictureBase64;

  PictureViewModel({
    required this.saleId,
    required this.pictureId,
    required this.userPhNo,
    required this.pictureBase64,
  });

  factory PictureViewModel.fromJson(Map<String, dynamic> json) {
    return PictureViewModel(
      saleId: json["sale_id"]?.toString() ?? '',
      pictureId: json["media_id"]?.toString() ?? '',
      userPhNo: json["user_phno"]?.toString() ?? '',
      pictureBase64: json["base64_value"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sale_id": saleId,
      "media_id": pictureId,
      "user_phno": userPhNo,
      "base64_value": pictureBase64,
    };
  }
}

class PictureViewModelNotifier extends StateNotifier<List<PictureViewModel>> {
  PictureViewModelNotifier() : super([]); // Initialize with an empty list

  // Update the entire list of pictures
  void updatePictures(List<PictureViewModel> newPictures) {
    state = newPictures;
  }

  // Add a single picture to the list
  void addPicture(PictureViewModel newPicture) {
    state = [...state, newPicture];
  }

  // Add multiple pictures to the list
  void addAllPictures(List<PictureViewModel> newPictures) {
    state = [...state, ...newPictures];
  }

  // Remove a picture by its ID
  void removePicture(String pictureId) {
    state = state.where((picture) => picture.pictureId != pictureId).toList();
  }
}
