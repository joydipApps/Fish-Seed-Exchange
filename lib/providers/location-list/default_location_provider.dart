import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location-list/default_location_model.dart';
import '../../service/location-list/default_location_service.dart';

// Provider for managing default location list model state
final defaultLocationModelProvider = StateNotifierProvider<
    DefaultLocationModelNotifier, List<DefaultLocationModel>>(
  (ref) => DefaultLocationModelNotifier(),
);

// Provider for accessing default location service
final defaultLocationServiceProvider = Provider<DefaultLocationService>(
  (ref) => DefaultLocationService(),
);

// Provider for managing the success state of default location list operations
final defaultLocationSuccessProvider =
    StateNotifierProvider<DefaultLocationSuccessNotifier, bool>(
  (ref) => DefaultLocationSuccessNotifier(),
);

// Notifier class for managing the success state of default location list operations
class DefaultLocationSuccessNotifier extends StateNotifier<bool> {
  DefaultLocationSuccessNotifier() : super(false); // Initialize with false

  void setDefaultLocationSuccess(bool value) {
    state = value;
  }
}
