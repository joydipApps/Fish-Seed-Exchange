import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/local_shared_Storage.dart';

// Provider for providing the phone number
// final phoneNoProvider = FutureProvider<String>((ref) async {
//   final phoneNo = await LocalSharedStorage.getPhoneNo();
//   return phoneNo;
// });

final phoneNoProvider = StateNotifierProvider<PhoneNoNotifier, String>((ref) {
  return PhoneNoNotifier();
});

class PhoneNoNotifier extends StateNotifier<String> {
  PhoneNoNotifier() : super(""); // Initialize with an empty string

  Future<void> populatePhoneNo() async {
    final phoneNo = await LocalSharedStorage.getPhoneNo();
    state = phoneNo; // Set the phone number obtained from storage
  }

  void setNumber(String phoneNumber) {
    state = phoneNumber; // Update the phone number
  }
}
