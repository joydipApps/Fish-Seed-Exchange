import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeedSaleAddModel {
  final String saleId;
  final String userPhoneNumber;
  final String categoryName;
  final String fishName;
  final int fishQuantity;
  final DateTime sellingDate;
  final DateTime nettingDate;
  final double rate;
  final String qtyUom;
  final String remarks;
  final String locationId;
  final double locationLat;
  final double locationLon;

  SeedSaleAddModel({
    required this.saleId,
    required this.userPhoneNumber,
    required this.categoryName,
    required this.fishName,
    required this.fishQuantity,
    required this.sellingDate,
    required this.nettingDate,
    required this.rate,
    required this.qtyUom,
    required this.remarks,
    required this.locationId,
    required this.locationLat,
    required this.locationLon,
  });

  Map<String, dynamic> toJson() {
    return {
      'sale_id': saleId,
      'user_phno': userPhoneNumber,
      'cat_name': categoryName,
      'fish_name': fishName,
      'fish_qty': fishQuantity,
      'selling_date': sellingDate.toIso8601String(),
      'netting_date': nettingDate.toIso8601String(),
      'rate': rate,
      'qty_uom': qtyUom,
      'remarks': remarks,
      'location_id': locationId,
      'location_lat': locationLat,
      'location_lon': locationLon,
    };
  }

  factory SeedSaleAddModel.fromJson(Map<String, dynamic> json) {
    return SeedSaleAddModel(
      saleId: json['sale_id'],
      userPhoneNumber: json['user_phno'],
      categoryName: json['cat_name'],
      fishName: json['fish_name'],
      fishQuantity: json['fish_qty'],
      sellingDate: DateTime.parse(json['selling_date']),
      nettingDate: DateTime.parse(json['netting_date']),
      rate: (json['rate'] as num).toDouble(),
      qtyUom: json['qty_uom'],
      remarks: json['remarks'],
      locationId: json['location_id'] ?? '0',
      locationLat: (json['location_lat'] as num).toDouble(),
      locationLon: (json['location_lon'] as num).toDouble(),
    );
  }
}

class SeedSaleAddModelNotifier extends StateNotifier<SeedSaleAddModel?> {
  SeedSaleAddModelNotifier() : super(null);

  void addSale(SeedSaleAddModel sale) {
    state = sale;
  }

  void removeSale() {
    state = null;
  }
}
