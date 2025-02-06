import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedFishNameProvider =
    StateNotifierProvider<SelectedFishNameNotifier, String?>((ref) {
  return SelectedFishNameNotifier();
});

class SelectedFishNameNotifier extends StateNotifier<String?> {
  SelectedFishNameNotifier() : super(null); // Initialize with null

  void setSelectedFishName(String? fishName) {
    state = fishName;
  }

  void reset() {
    state = null;
  }
}
