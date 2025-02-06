import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryNameProvider =
    StateNotifierProvider<SelectedCategoryNameNotifier, String?>((ref) {
  return SelectedCategoryNameNotifier();
});

class SelectedCategoryNameNotifier extends StateNotifier<String?> {
  SelectedCategoryNameNotifier() : super(null); // Initialize with null

  void setSelectedCategoryName(String? fishCategory) {
    state = fishCategory;
  }

  void reset() {
    state = null;
  }
}
