import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/local_shared_Storage.dart';

final phoneNoPresenceProvider =
    StateNotifierProvider<PhoneNoPresenceNotifier, bool>((ref) {
  return PhoneNoPresenceNotifier();
});

class PhoneNoPresenceNotifier extends StateNotifier<bool> {
  PhoneNoPresenceNotifier() : super(false);

  Future<void> populatePhoneNoPresence() async {
    final isPhoneNoPresent = await LocalSharedStorage.getPhoneNo();
    state = isPhoneNoPresent.isNotEmpty;
  }

  void setPresence(bool isPresent) {
    state = isPresent;
  }
}
