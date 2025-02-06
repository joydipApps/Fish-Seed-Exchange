import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishCategoryModel {
  String categoryId;
  String categoryName;

  FishCategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory FishCategoryModel.fromJson(Map<String, dynamic> json) {
    return FishCategoryModel(
      categoryId: json["cat_id"]?.toString() ?? '',
      categoryName: json["cat_name"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cat_id": categoryId,
      "cat_name": categoryName,
    };
  }
}

class FishCategoryModelNotifier extends StateNotifier<List<FishCategoryModel>> {
  FishCategoryModelNotifier() : super([]); // Initialize with an empty list

  void setCategories(List<FishCategoryModel> newCategories) {
    state = newCategories;
  }

  void addCategory(FishCategoryModel newCategory) {
    state = [...state, newCategory]; // Add a single video to the list
  }

  void addAllCategories(List<FishCategoryModel> newCategories) {
    state = [...state, ...newCategories]; // Add multiple videos to the list
  }
}
