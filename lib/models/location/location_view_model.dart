import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationViewModel {
  String userPhoneNo;
  String locationId;
  String locationName;
  String locationType;
  String village;
  String postOffice;
  String district;
  String policeStation;
  String panchayat;
  String state;
  String pinCode;
  double lat;
  double lon;
  String mouja;
  bool isActive;

  LocationViewModel({
    required this.userPhoneNo,
    required this.locationId,
    required this.locationName,
    required this.locationType,
    required this.village,
    required this.postOffice,
    required this.district,
    required this.policeStation,
    required this.panchayat,
    required this.state,
    required this.pinCode,
    required this.lat,
    required this.lon,
    required this.mouja,
    required this.isActive,
  });

  factory LocationViewModel.fromJson(Map<String, dynamic> json) {
    return LocationViewModel(
      userPhoneNo: json["user_phno"] ?? '',
      locationId: json["location_id"] ?? '0',
      locationName: json["location_name"] ?? '',
      locationType: json["location_type"] ?? '',
      village: json["village"] ?? '',
      postOffice: json["post_office"] ?? '',
      district: json["district"] ?? '',
      policeStation: json["police_station"] ?? '',
      panchayat: json["panchayat"] ?? '',
      state: json["state"] ?? '',
      pinCode: json["pincode"] ?? '',
      lat: double.parse(json["lat"] ?? '0'),
      lon: double.parse(json["lon"] ?? '0'),
      mouja: json["mouja"] ?? '',
      isActive: json["is_active"] == 'true',
    );
  }

  // TODO update 8june
  // static List<LocationViewModel> listFromJson(List<dynamic> json) {
  //   return json.map(LocationViewModel.fromJson).toList();
  // }

  static List<LocationViewModel> listFromJson(List<dynamic> json) {
    return json
        .map<LocationViewModel>((dynamic item) =>
            LocationViewModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "user_phno": userPhoneNo,
      "location_id": locationId,
      "location_name": locationName,
      "location_type": locationType,
      "village": village,
      "post_office": postOffice,
      "district": district,
      "police_station": policeStation,
      "panchayat": panchayat,
      "state": state,
      "pincode": pinCode,
      "lat": lat.toString(),
      "lon": lon.toString(),
      "mouja": mouja,
      "is_active": isActive.toString(),
    };
  }
}

class LocationViewModelNotifier extends StateNotifier<List<LocationViewModel>> {
  LocationViewModelNotifier() : super([]); // Initialize with an empty list

  void updateLocations(List<LocationViewModel> newLocations) {
    state = newLocations;
  }

  void addLocation(LocationViewModel newLocation) {
    state = [...state, newLocation]; // Add a single location to the list
  }

  void addAllLocations(List<LocationViewModel> newLocations) {
    state.addAll(newLocations); // Add multiple location to the list
  }

  void removeLocation(String locationId) {
    state =
        state.where((location) => location.locationId != locationId).toList();
  }
}
