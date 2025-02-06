import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationListModel {
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

  LocationListModel(
      {required this.userPhoneNo,
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
      required this.isActive});

  factory LocationListModel.fromJson(Map<String, dynamic> json) {
    return LocationListModel(
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
      lat: double.tryParse(json["lat"]) ?? 0.0,
      lon: double.tryParse(json["lon"]) ?? 0.0,
      mouja: json["mouja"] ?? '',
      isActive: json["is_active"] == 'true',
    );
  }

  // TODO update 8june
  // static List<LocationListModel> listFromJson(List<dynamic> json) {
  //   return json.map(LocationListModel.fromJson).toList();
  // }

  static List<LocationListModel> listFromJson(List<dynamic> json) {
    return json
        .map<LocationListModel>((dynamic item) =>
            LocationListModel.fromJson(item as Map<String, dynamic>))
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

class LocationListModelNotifier extends StateNotifier<List<LocationListModel>> {
  LocationListModelNotifier() : super([]); // Initialize with an empty list

  void updateAddress(List<LocationListModel> newAddresses) {
    state = newAddresses;
  }

  void addAddress(LocationListModel newAddress) {
    state = [...state, newAddress]; // Add a single Address to the list
  }

  void addAllAddress(List<LocationListModel> newAddresses) {
    state.addAll(newAddresses); // Add multiple Addresses to the list
  }

  // Method to set isActive for the selected location ID

  void setActiveLocation(String selectedId) {
    for (var location in state) {
      location.isActive = location.locationId == selectedId;
    }
    // Notify listeners about the change
    state = List.from(state);
  }

  void removeLocation(String addressId) {
    // Create a new list without the location to be removed
    final newState =
        state.where((location) => location.locationId != addressId).toList();
    // Update the state with the new list
    state = newState;
  }
}
