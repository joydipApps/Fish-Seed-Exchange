import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaleLocationModel {
  String userPhoneNo;
  String saleId; // Updated variable name
  String addressId;

  SaleLocationModel({
    required this.userPhoneNo,
    required this.saleId,
    required this.addressId,
  });

  factory SaleLocationModel.fromJson(Map<String, dynamic> json) {
    return SaleLocationModel(
      userPhoneNo: json["user_phno"] ?? '',
      saleId: json["sale_id"] ?? '0', // Use "sale_id" from JSON
      addressId: json["location_id"] ?? '0',
    );
  }

  // TODO update 8june
  // static List<SaleLocationModel> listFromJson(List<dynamic> json) {
  //   return json.map(SaleLocationModel.fromJson).toList();
  // }

  static List<SaleLocationModel> listFromJson(List<dynamic> json) {
    return json
        .map((dynamic item) =>
            SaleLocationModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "user_phno": userPhoneNo,
      "sale_id": saleId, // Use "sale_id" for consistency
      "location_id": addressId, // Use "location_id" for consistency
    };
  }
}

class SaleLocationModelNotifier extends StateNotifier<List<SaleLocationModel>> {
  SaleLocationModelNotifier() : super([]); // Initialize with an empty list

  void updateAddress(List<SaleLocationModel> newSale) {
    state = newSale;
  }

  void addAddress(SaleLocationModel newSale) {
    state = [...state, newSale]; // Add a single Address to the list
  }

  void addAllAddress(List<SaleLocationModel> newSales) {
    state = [...state, ...newSales]; // Add multiple Addresses to the list
  }
}
