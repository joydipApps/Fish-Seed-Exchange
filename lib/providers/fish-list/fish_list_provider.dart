import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/fish-list/fish_list_model.dart';
import '../../service/fish-list/fish_list_service.dart';

final fishListModelProvider =
    StateNotifierProvider<FishListModelNotifier, List<FishListModel>>((ref) {
  debugPrint('1. Creating fishListModelProvider'); // Debug point 1
  return FishListModelNotifier();
});

final fishListServiceProvider = Provider<FishListService>((ref) {
  debugPrint('2. Creating fishListServiceProvider'); // Debug point 2
  return FishListService();
});

final fishListSuccessProvider =
    StateNotifierProvider<FishListSuccessNotifier, bool>((ref) {
  debugPrint('3. Creating fishListSuccessProvider'); // Debug point 3
  return FishListSuccessNotifier(); // You'll need to create this notifier class
});

class FishListSuccessNotifier extends StateNotifier<bool> {
  FishListSuccessNotifier() : super(false); // Initialize with false

  void setFishListSuccess(bool value) {
    debugPrint('4. Setting enquiry view success: $value'); // Debug point 4
    state = value;
  }
}
