import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../seed_sale/seed_sale_view_provider.dart';

// Provider for SaleVideoCounter based on saleId
final saleVideoCounterProvider =
    StateNotifierProvider.family<SaleVideoCounter, int, String>((ref, saleId) {
  final seedSaleList = ref.watch(seedSaleViewModelProvider);

  // Find the SeedSaleViewModel with matching saleId
  final seedSale = seedSaleList.firstWhere((sale) => sale.saleId == saleId);

  // Initialize the counter with the existing video count
  return SaleVideoCounter(initialCount: seedSale.seedVideoCount);
});

// StateNotifier for managing counters per sale ID
class SaleVideoCounter extends StateNotifier<int> {
  SaleVideoCounter({required int initialCount}) : super(initialCount);

  // Method to increment the counter for the current sale ID
  void increment() {
    state = state + 1;
  }

  // Method to decrement the counter for the current sale ID
  void decrement() {
    if (state > 0) {
      state = state - 1;
    }
  }

  // Method to reset the counter for the current sale ID
  void reset() {
    state = 0;
  }
}
