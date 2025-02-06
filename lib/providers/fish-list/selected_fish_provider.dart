import 'package:flutter_riverpod/flutter_riverpod.dart';

// for fish list selection
final selectedFishProvider = StateProvider<String>((ref) => '');

// Define a class that extends StateNotifier with the desired state type
class SelectedFishState extends StateNotifier<String> {
  SelectedFishState() : super(''); // Initialize with default value

  // Method to update the fish state
  void updateFish(String newFish) {
    state = newFish; // Update the state with the new fish
  }
}
