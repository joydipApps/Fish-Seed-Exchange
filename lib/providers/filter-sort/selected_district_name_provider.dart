import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDistrictNameProvider =
    StateNotifierProvider<SelectedDistrictNameNotifier, String?>((ref) {
  return SelectedDistrictNameNotifier();
});

class SelectedDistrictNameNotifier extends StateNotifier<String?> {
  SelectedDistrictNameNotifier() : super(null); // Initialize with null

  void setSelectedDistrictName(String? districtName) {
    //  district
    state = districtName;
  }

  void reset() {
    state = null;
  }
}
