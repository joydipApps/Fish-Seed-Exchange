import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/seed_sale/seed_sale_add_model.dart';
import '../../service/seed-sale/seed_sale_add_service.dart';

final seedSaleAddModelProvider =
    StateNotifierProvider<SeedSaleAddModelNotifier, SeedSaleAddModel?>((ref) {
  return SeedSaleAddModelNotifier();
});

final seedSaleAddServiceProvider = Provider<SeedSaleAddService>((ref) {
  return SeedSaleAddService();
});

final seedSaleAddSuccessProvider =
    StateNotifierProvider<SeedSaleAddSuccessNotifier, bool>((ref) {
  return SeedSaleAddSuccessNotifier(); // You'll need to create this notifier class
});

class SeedSaleAddSuccessNotifier extends StateNotifier<bool> {
  SeedSaleAddSuccessNotifier() : super(false); // Initialize with false

  void setSeedSaleAddSuccess(bool value) {
    state = value;
  }
}
