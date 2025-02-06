import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../seed_sale/seed_sale_view_provider.dart';

final toggleFishCategoryProvider = StateProvider<bool>((ref) => false);

final fishCategoryFilterProvider = Provider<List<String>>((ref) {
  // Access the list of SeedSaleViewModel instances from the provider
  final seedSales = ref.watch(
      seedSaleViewModelProvider); // Assuming seedSalesProvider is defined elsewhere

  // Extract unique fish names using a Set
  final uniqueFishCategorys =
      seedSales.map((sale) => sale.categoryName).toSet().toList();

  return uniqueFishCategorys;
});
