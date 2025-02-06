import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location-list/location_list_model.dart';
import '../../service/location-list/location_list_update_service.dart';

final locationUpdateModelProvider =
    StateNotifierProvider<LocationListModelNotifier, List<LocationListModel>>(
        (ref) {
  return LocationListModelNotifier();
});

final locationUpdateServiceProvider = Provider<LocationUpdateService>((ref) {
  return LocationUpdateService();
});

final locationUpdateSuccessProvider =
    StateNotifierProvider<LocationUpdateSuccessNotifier, bool>((ref) {
  return LocationUpdateSuccessNotifier(); // You'll need to create this notifier class
});

//todo success by each location id
class LocationUpdateSuccessNotifier extends StateNotifier<bool> {
  LocationUpdateSuccessNotifier() : super(false); // Initialize with false

  void setLocationUpdateSuccess(bool value) {
    state = value;
  }
}
