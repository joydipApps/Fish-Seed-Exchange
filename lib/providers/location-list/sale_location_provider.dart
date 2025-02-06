import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/location-list/sale_location_model.dart';
import '../../service/location/sale_location_service.dart';

// Provider for managing sale location list model state
final saleLocationModelProvider =
    StateNotifierProvider<SaleLocationModelNotifier, List<SaleLocationModel>>(
  (ref) => SaleLocationModelNotifier(),
);

// Provider for accessing sale location service
final saleLocationServiceProvider = Provider<SaleLocationService>(
  (ref) => SaleLocationService(),
);

// Provider for managing the success state of sale location list operations
final saleLocationSuccessProvider =
    StateNotifierProvider<SaleLocationSuccessNotifier, bool>(
  (ref) => SaleLocationSuccessNotifier(),
);

// Notifier class for managing the success state of sale location list operations
class SaleLocationSuccessNotifier extends StateNotifier<bool> {
  SaleLocationSuccessNotifier() : super(false); // Initialize with false

  void setSaleLocationSuccess(bool value) {
    state = value;
  }
}
