import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../seed_sale/seed_sale_view_provider.dart';

final toggleGroupNameProvider = StateProvider<bool>((ref) => false);

final groupNameFilterProvider = Provider<List<String>>((ref) {
  // Access the list of SeedSaleViewModel instances from the provider
  final seedSales = ref.watch(
      seedSaleViewModelProvider); // Assuming seedSalesProvider is defined elsewhere

  // Extract unique group names using a Set
  final uniqueGroupNames =
      seedSales.map((sale) => sale.userType).toSet().toList();

  return uniqueGroupNames;
});
