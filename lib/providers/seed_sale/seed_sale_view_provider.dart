import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/seed_sale/seed_sale_view_model.dart';
import '../../service/seed-sale/seed_sale_view_service.dart';

final seedSaleViewModelProvider =
    StateNotifierProvider<SeedSaleViewModelNotifier, List<SeedSaleViewModel>>(
        (ref) {
  return SeedSaleViewModelNotifier();
});

// no of records count
final seedSaleCountProvider = Provider<int>((ref) {
  final seedSales = ref.watch(seedSaleViewModelProvider);
  return seedSales.length; // Count the number of seed sales
});

final seedSaleViewServiceProvider = Provider<SeedSaleViewService>((ref) {
  return SeedSaleViewService();
});

final seedSaleViewSuccessProvider =
    StateNotifierProvider<SeedSaleViewSuccessNotifier, bool>((ref) {
  return SeedSaleViewSuccessNotifier(); // You'll need to create this notifier class
});

class SeedSaleViewSuccessNotifier extends StateNotifier<bool> {
  SeedSaleViewSuccessNotifier() : super(false); // Initialize with false

  void setSeedSaleViewSuccess(bool value) {
    state = value;
  }
}
