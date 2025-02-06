import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishListModel {
  String fishName;

  FishListModel({
    required this.fishName,
  });

  factory FishListModel.fromJson(Map<String, dynamic> json) {
    // Access the "fish_name " key with trimming to remove extra space
    String fishName = (json['fish_name'] as String?)?.trim() ?? '';

    return FishListModel(
      fishName: fishName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fish_name": fishName,

      // Serialize the fishName field with key "fish_name"
    };
  }
}

class FishListModelNotifier extends StateNotifier<List<FishListModel>> {
  FishListModelNotifier() : super([]); // Initialize with an empty list

  void setFish(FishListModel newFish) {
    state = [newFish]; // Replace the entire list with a single fish
  }

  void addFish(FishListModel newFish) {
    state = [...state, newFish]; // Add a single fish to the existing list
  }

  void setAllFish(List<FishListModel> newFishList) {
    state = newFishList; // Replace the entire list with a new list of fish
  }
}
