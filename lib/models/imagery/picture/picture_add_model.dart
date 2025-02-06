import 'package:flutter_riverpod/flutter_riverpod.dart';

class PictureAddModel {
  String saleId;
  String pictureId;
  String userPhNo;
  String pictureBase64;

  PictureAddModel({
    required this.pictureId,
    required this.saleId,
    required this.userPhNo,
    required this.pictureBase64,
  });

  factory PictureAddModel.fromJson(Map<String, dynamic> json) {
    return PictureAddModel(
      pictureId: json["media_id"]?.toString() ?? '',
      saleId: json["sale_id"]?.toString() ?? '',
      userPhNo: json["user_phno"]?.toString() ?? '',
      pictureBase64: json["base64_value"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "media_id": pictureId,
      "sale_id": saleId,
      "user_phno": userPhNo,
      "base64": pictureBase64,
    };
  }
}

class PictureAddModelNotifier extends StateNotifier<List<PictureAddModel>> {
  PictureAddModelNotifier() : super([]);

  void updatePictures(List<PictureAddModel> newPictures) {
    state = newPictures;
  }

  void addPicture(PictureAddModel newPicture) {
    state = [...state, newPicture];
  }

  void addAllPictures(List<PictureAddModel> newPictures) {
    state = [...state, ...newPictures];
  }

  void removePicture(String pictureId) {
    state = state.where((picture) => picture.pictureId != pictureId).toList();
  }
}
