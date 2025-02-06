import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeedSaleViewModel {
  final String saleId;
  final String userName;
  final String userType;
  final String userPhoneNumber;
  final String categoryName;
  final String fishName;
  final int fishQuantity;
  final DateTime sellingDate;
  final DateTime nettingDate;
  final double rate;
  final String qtyUom;
  final int seedPicCount;
  final int seedVideoCount;
  final String remarks;
  final String locationId;
  final double locationLat;
  final double locationLon;
  final String locationDistrict;

  SeedSaleViewModel({
    required this.saleId,
    required this.userName,
    required this.userType,
    required this.userPhoneNumber,
    required this.categoryName,
    required this.fishName,
    required this.fishQuantity,
    required this.sellingDate,
    required this.nettingDate,
    required this.rate,
    required this.qtyUom,
    required this.seedPicCount,
    required this.seedVideoCount,
    required this.remarks,
    required this.locationId,
    required this.locationLat,
    required this.locationLon,
    required this.locationDistrict,
  });

  Map<String, dynamic> toJson() {
    return {
      'sale_id': saleId,
      'user_name': userName,
      'user_type': userType,
      'user_phno': userPhoneNumber,
      'cat_name': categoryName,
      'fish_name': fishName,
      'fish_qty': fishQuantity,
      'selling_date': sellingDate.toIso8601String(),
      'netting_date': nettingDate.toIso8601String(),
      'rate': rate,
      'qty_uom': qtyUom,
      'seed_pic_count': seedPicCount,
      'seed_video_count': seedVideoCount,
      'remarks': remarks,
      'location_id': locationId,
      'location_lat': locationLat,
      'location_lon': locationLon,
      'location_district': locationDistrict,
    };
  }

  factory SeedSaleViewModel.fromJson(Map<String, dynamic> json) {
    return SeedSaleViewModel(
      saleId: json['sale_id'],
      userName: json['user_name'],
      userType: json['user_type'],
      userPhoneNumber: json['user_phno'],
      categoryName: json['cat_name'],
      fishName: json['fish_name'],
      fishQuantity: int.parse(json['fish_qty']),
      sellingDate: DateTime.parse(json['selling_date']),
      nettingDate: DateTime.parse(json['netting_date']),
      rate: double.parse(json['rate']),
      qtyUom: json['qty_uom'],
      seedPicCount: json['seed_pic_count'] as int,
      seedVideoCount: json['seed_video_count'] as int,
      remarks: json['remarks'],
      locationId: json['location_id'] ?? '0', // Set default value to 0
      locationLat: double.parse(json['location_lat']), // Set default value to 0
      locationLon: double.parse(json['location_lon']), // Set default value to 0
      locationDistrict: json['location_district'],
    );
  }
}

class SeedSaleViewModelNotifier extends StateNotifier<List<SeedSaleViewModel>> {
  SeedSaleViewModelNotifier() : super([]);

  void addSale(SeedSaleViewModel sale) {
    state = [...state, sale];
  }

  void addAllSales(List<SeedSaleViewModel> sales) {
    state = [...state, ...sales];
  }
  // void addAllSales(List<SeedSaleViewModel> sales) {
  //   state.addAll(sales);
  // }

  void removeSale(SeedSaleViewModel sale) {
    state = state.where((s) => s != sale).toList();
  }
}
