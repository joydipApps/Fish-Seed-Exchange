import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location/location_view_model.dart';
import '../../service/location/location_view_service.dart';

final locationViewModelProvider =
    StateNotifierProvider<LocationViewModelNotifier, List<LocationViewModel>>(
        (ref) {
  return LocationViewModelNotifier();
});

final locationViewServiceProvider = Provider<LocationViewService>((ref) {
  return LocationViewService();
});

final locationViewSuccessProvider =
    StateNotifierProvider<LocationViewSuccessNotifier, Map<String, bool>>(
        (ref) {
  return LocationViewSuccessNotifier();
});

// Define the notifier class
class LocationViewSuccessNotifier extends StateNotifier<Map<String, bool>> {
  LocationViewSuccessNotifier() : super({});

  void setLocationViewSuccess(String locationId, bool value) {
    state = {...state, locationId: value};
  }
}
