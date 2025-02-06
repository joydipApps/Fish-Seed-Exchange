import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../seed_sale/seed_sale_view_provider.dart';

final toggleDistrictNameProvider = StateProvider<bool>((ref) => false);

final districtNameFilterProvider = Provider<List<String>>((ref) {
  // Access the list of SeedSaleViewModel instances from the provider
  final seedSales = ref.watch(
      seedSaleViewModelProvider); // Assuming seedSalesProvider is defined elsewhere

  // Extract unique district names using a Set
  final uniqueDistrictNames =
      seedSales.map((sale) => sale.locationDistrict).toSet().toList();

  return uniqueDistrictNames;
});
