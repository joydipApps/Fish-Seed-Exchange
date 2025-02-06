import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultLocationModel {
  String userPhoneNo;
  String addressId;

  DefaultLocationModel({
    required this.userPhoneNo,
    required this.addressId,
  });

  factory DefaultLocationModel.fromJson(Map<String, dynamic> json) {
    return DefaultLocationModel(
      userPhoneNo: json["user_phno"] ?? '',
      addressId: json["location_id"] ?? '0',
    );
  }

  // TODO update 8june
  // static List<DefaultLocationModel> listFromJson(List<dynamic> json) {
  //   return json.map(DefaultLocationModel.fromJson).toList();
  // }

  static List<DefaultLocationModel> listFromJson(List<dynamic> json) {
    return json
        .map((dynamic item) =>
            DefaultLocationModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "user_phno": userPhoneNo,
      "location_id": addressId,
    };
  }
}

class DefaultLocationModelNotifier
    extends StateNotifier<List<DefaultLocationModel>> {
  DefaultLocationModelNotifier() : super([]); // Initialize with an empty list

  void updateAddress(List<DefaultLocationModel> newDefault) {
    state = newDefault;
  }

  void addAddress(DefaultLocationModel newDefault) {
    state = [...state, newDefault]; // Add a single Address to the list
  }

  void addAllAddress(List<DefaultLocationModel> newDefaults) {
    state = [...state, ...newDefaults]; // Add multiple Addresses to the list
  }
}
