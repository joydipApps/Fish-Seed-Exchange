// location_list_provider

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location-list/location_list_model.dart';
import '../../service/location-list/location_list_service.dart';

final locationListModelProvider =
    StateNotifierProvider<LocationListModelNotifier, List<LocationListModel>>(
        (ref) {
  return LocationListModelNotifier();
});

final locationListServiceProvider = Provider<LocationListService>((ref) {
  return LocationListService();
});

final locationListSuccessProvider =
    StateNotifierProvider<LocationListSuccessNotifier, bool>((ref) {
  return LocationListSuccessNotifier(); // You'll need to create this notifier class
});

class LocationListSuccessNotifier extends StateNotifier<bool> {
  LocationListSuccessNotifier() : super(false); // Initialize with false

  void setLocationListSuccess(bool value) {
    state = value;
  }
}

// New provider for count of records
final locationCountProvider = Provider<int>((ref) {
  final locationList = ref.watch(locationListModelProvider);
  return locationList.length;
});

// New provider for active location
final activeLocationProvider = Provider<LocationListModel>((ref) {
  final locationList = ref.watch(locationListModelProvider);
  final activeLocation = locationList.firstWhere(
    (location) => location.isActive,
    orElse: () => LocationListModel(
      userPhoneNo: '',
      locationId: '',
      locationName: '',
      locationType: '',
      village: '',
      postOffice: '',
      district: '',
      policeStation: '',
      panchayat: '',
      state: '',
      pinCode: '',
      lat: 0.0,
      lon: 0.0,
      mouja: '',
      isActive: false, // Default inactive state
    ), // Return a default instance
  );
  return activeLocation;
});
