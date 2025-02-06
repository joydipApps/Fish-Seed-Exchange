import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/leads/leads_view_model.dart';
import '../../service/leads/leads_update_service.dart';

final leadsUpdateModelProvider =
    StateNotifierProvider<LeadsViewModelNotifier, List<LeadsViewModel>>((ref) {
  debugPrint('1. Creating leadsViewModelProvider'); // Debug point 1
  return LeadsViewModelNotifier();
});

final leadsUpdateServiceProvider = Provider<LeadsUpdateService>((ref) {
  debugPrint('2. Creating leadsViewServiceProvider'); // Debug point 2
  return LeadsUpdateService();
});

final leadsViewSuccessProvider =
    StateNotifierProvider<LeadsUpdateSuccessNotifier, bool>((ref) {
  debugPrint('3. Creating leadsViewSuccessProvider'); // Debug point 3
  return LeadsUpdateSuccessNotifier(); // You'll need to create this notifier class
});

class LeadsUpdateSuccessNotifier extends StateNotifier<bool> {
  LeadsUpdateSuccessNotifier() : super(false); // Initialize with false

  void setLeadsUpdateSuccess(bool value) {
    debugPrint('4. Setting leads view success: $value'); // Debug point 4
    state = value;
  }
}
