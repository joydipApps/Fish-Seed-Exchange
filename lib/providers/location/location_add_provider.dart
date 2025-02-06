import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location/location_add_model.dart';
import '../../service/location/location_add_service.dart';

final locationAddModelProvider =
    StateNotifierProvider<LocationAddModelNotifier, List<LocationAddModel>>(
        (ref) {
  return LocationAddModelNotifier();
});

final locationAddServiceProvider = Provider<LocationAddService>((ref) {
  return LocationAddService();
});

final locationAddSuccessProvider =
    StateNotifierProvider<LocationAddSuccessNotifier, bool>((ref) {
  return LocationAddSuccessNotifier(); // You'll need to create this notifier class
});

//todo success by each location id
class LocationAddSuccessNotifier extends StateNotifier<bool> {
  LocationAddSuccessNotifier() : super(false); // Initialize with false

  void setLocationAddSuccess(bool value) {
    state = value;
  }
}
