import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location/location_remove_model.dart';
import '../../service/location/location_remove_service.dart';

final locationRemoveModelProvider = StateNotifierProvider<
    LocationRemoveModelNotifier, List<LocationRemoveModel>>((ref) {
  return LocationRemoveModelNotifier();
});

final locationRemoveServiceProvider = Provider<LocationRemoveService>((ref) {
  return LocationRemoveService();
});

final locationRemoveSuccessProvider =
    StateNotifierProvider<LocationRemoveSuccessNotifier, Map<String, bool>>(
        (ref) {
  return LocationRemoveSuccessNotifier();
});

// Define the notifier class
class LocationRemoveSuccessNotifier extends StateNotifier<Map<String, bool>> {
  LocationRemoveSuccessNotifier() : super({});

  void setLocationRemoveSuccess(String locationId, bool value) {
    state = {...state, locationId: value};
  }
}
