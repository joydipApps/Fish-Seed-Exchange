import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationAddModel {
  String locationId;
  String userPhoneNo;
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

  LocationAddModel({
    required this.locationId,
    required this.userPhoneNo,
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

  factory LocationAddModel.fromJson(Map<String, dynamic> json) {
    return LocationAddModel(
      locationId: json["location_id"] ?? '0',
      userPhoneNo: json["user_phno"] ?? '',
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

  Map<String, dynamic> toJson() {
    return {
      "location_id": locationId,
      "user_phno": userPhoneNo,
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

class LocationAddModelNotifier extends StateNotifier<List<LocationAddModel>> {
  LocationAddModelNotifier() : super([]); // Initialize with an empty list

  void updateLocations(List<LocationAddModel> newLocations) {
    state = newLocations;
  }

  void addLocation(LocationAddModel newLocation) {
    state = [...state, newLocation]; // Add a single location to the list
  }

  void addAllLocations(List<LocationAddModel> newLocations) {
    state.addAll(newLocations); // Add multiple location to the list
  }
}
