import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/seed_sale/seed_sale_view_model.dart';
import '../../service/seed-sale/seed_sale_update_service.dart';

final seedSaleUpdateModelProvider =
    StateNotifierProvider<SeedSaleViewModelNotifier, List<SeedSaleViewModel>>(
        (ref) {
  return SeedSaleViewModelNotifier();
});

final seedSaleUpdateServiceProvider = Provider<SeedSaleUpdateService>((ref) {
  return SeedSaleUpdateService();
});

final seedSaleUpdateSuccessProvider =
    StateNotifierProvider<SeedSaleUpdateSuccessNotifier, bool>((ref) {
  return SeedSaleUpdateSuccessNotifier(); // You'll need to create this notifier class
});

class SeedSaleUpdateSuccessNotifier extends StateNotifier<bool> {
  SeedSaleUpdateSuccessNotifier() : super(false); // Initialize with false

  void setSeedSaleUpdateSuccess(bool value) {
    state = value;
  }
}
