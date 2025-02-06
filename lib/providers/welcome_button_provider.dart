import 'package:flutter_riverpod/flutter_riverpod.dart';

final welcomeButtonStateProvider =
    StateNotifierProvider<WelcomeButtonNotifier, bool>(
  (_) => WelcomeButtonNotifier(),
);

class WelcomeButtonNotifier extends StateNotifier<bool> {
  WelcomeButtonNotifier() : super(true);

  void disableButton() {
    state = false;
    // Re-enable the button after a certain duration (e.g., 2 seconds)
    Future.delayed(const Duration(seconds: 3), enableButton);
  }

  void enableButton() {
    state = true;
  }
}
