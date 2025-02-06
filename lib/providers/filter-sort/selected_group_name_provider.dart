import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGroupNameProvider =
    StateNotifierProvider<SelectedGroupNameNotifier, String?>((ref) {
  return SelectedGroupNameNotifier();
});

class SelectedGroupNameNotifier extends StateNotifier<String?> {
  SelectedGroupNameNotifier() : super(null); // Initialize with null

  void setSelectedGroupName(String? groupName) {
    //  user type
    state = groupName;
  }

  void reset() {
    state = null;
  }
}
