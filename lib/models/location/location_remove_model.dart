import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationRemoveModel {
  String locationId;

  LocationRemoveModel({
    required this.locationId,
  });

  factory LocationRemoveModel.fromJson(Map<String, dynamic> json) {
    return LocationRemoveModel(
      locationId: json["location_id"] ?? '0',
    );
  }

  // TODO update 8june
  // static List<LocationRemoveModel> listFromJson(List<dynamic> json) {
  //   return json.map(LocationRemoveModel.fromJson).toList();
  // }
  static List<LocationRemoveModel> listFromJson(List<dynamic> json) {
    return json
        .map<LocationRemoveModel>((item) =>
            LocationRemoveModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "location_id": locationId,
    };
  }
}

class LocationRemoveModelNotifier
    extends StateNotifier<List<LocationRemoveModel>> {
  LocationRemoveModelNotifier() : super([]); // Initialize with an empty list

  void updateLocations(List<LocationRemoveModel> newLocations) {
    state = newLocations;
  }

  void addLocation(LocationRemoveModel newLocation) {
    state = [...state, newLocation]; // Add a single location to the list
  }

  void addAllLocations(List<LocationRemoveModel> newLocations) {
    state = [...state, ...newLocations]; // Add multiple locations to the list
  }

  void removeLocation(String locationId) {
    state = state
        .where((location) => location.locationId != locationId)
        .toList(); // Remove location by id
  }
}
