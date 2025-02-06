import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/local_shared_Storage.dart';

final phoneNameProvider =
    StateNotifierProvider<PhoneNameNotifier, String>((ref) {
  return PhoneNameNotifier();
});

class PhoneNameNotifier extends StateNotifier<String> {
  PhoneNameNotifier() : super(""); // Initialize with an empty string

  Future<void> populatePhoneName() async {
    final phoneName = await LocalSharedStorage.getName();
    state = phoneName; // Set the phone number obtained from storage
  }

  void setName(String phoneName) {
    state = phoneName; // Update the phone number
  }
}
