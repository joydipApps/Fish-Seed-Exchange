import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/fish-category/fish_category_model.dart';
import '../../service/category/fish_category_service.dart';

// Provider for FishCategoryModelNotifier managing a list of FishCategoryModel
final fishCategoryModelProvider =
    StateNotifierProvider<FishCategoryModelNotifier, List<FishCategoryModel>>(
        (ref) {
  debugPrint('1. Creating fishCategoryModelProvider'); // Debug point 1
  return FishCategoryModelNotifier();
});

// Provider for FishCategoryService (you'll need to implement FishCategoryService)
final fishCategoryServiceProvider = Provider<FishCategoryService>((ref) {
  debugPrint('2. Creating fishCategoryServiceProvider'); // Debug point 2
  return FishCategoryService();
});

// Provider for FishCategorySuccessNotifier managing a boolean state
final fishCategorySuccessProvider =
    StateNotifierProvider<FishCategorySuccessNotifier, bool>((ref) {
  debugPrint('3. Creating fishCategorySuccessProvider'); // Debug point 3
  return FishCategorySuccessNotifier();
});

class FishCategorySuccessNotifier extends StateNotifier<bool> {
  FishCategorySuccessNotifier() : super(false); // Initialize with false

  void setFishCategorySuccess(bool value) {
    debugPrint('4. Setting category view success: $value'); // Debug point 4
    state = value;
  }
}
