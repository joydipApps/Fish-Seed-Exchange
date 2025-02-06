import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../seed_sale/seed_sale_view_provider.dart';

final toggleFishNameProvider = StateProvider<bool>((ref) => false);

final fishNameFilterProvider = Provider<List<String>>((ref) {
  // Access the list of SeedSaleViewModel instances from the provider
  final seedSales = ref.watch(
      seedSaleViewModelProvider); // Assuming seedSalesProvider is defined elsewhere

  // Extract unique fish names using a Set
  final uniqueFishNames =
      seedSales.map((sale) => sale.fishName).toSet().toList();

  return uniqueFishNames;
});
