import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../seed_sale/seed_sale_view_provider.dart';

// Provider for SalePictureCounter based on saleId
final salePictureCounterProvider =
    StateNotifierProvider.family<SalePictureCounter, int, String>(
        (ref, saleId) {
  final seedSaleList = ref.watch(seedSaleViewModelProvider);

  // Find the SeedSaleViewModel with matching saleId
  final seedSale = seedSaleList.firstWhere((sale) => sale.saleId == saleId);

  // Initialize the counter with the existing picture count
  return SalePictureCounter(initialCount: seedSale.seedPicCount);
});

// StateNotifier for managing counters per sale ID
class SalePictureCounter extends StateNotifier<int> {
  SalePictureCounter({required int initialCount}) : super(initialCount);

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
