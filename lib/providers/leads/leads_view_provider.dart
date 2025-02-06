import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/leads/leads_view_model.dart';
import '../../service/leads/leads_view_Service.dart';

final leadsViewModelProvider =
    StateNotifierProvider<LeadsViewModelNotifier, List<LeadsViewModel>>((ref) {
  debugPrint('1. Creating leadsViewModelProvider'); // Debug point 1
  return LeadsViewModelNotifier();
});

// no of records count
final leadsCountProvider = Provider<int>((ref) {
  final leadsCount = ref.watch(leadsViewModelProvider);
  return leadsCount.length; // Count the number of seed sales
});

final leadsViewServiceProvider = Provider<LeadsViewService>((ref) {
  debugPrint('2. Creating leadsViewServiceProvider'); // Debug point 2
  return LeadsViewService();
});

final leadsViewSuccessProvider =
    StateNotifierProvider<LeadsViewSuccessNotifier, bool>((ref) {
  debugPrint('3. Creating leadsViewSuccessProvider'); // Debug point 3
  return LeadsViewSuccessNotifier(); // You'll need to create this notifier class
});

class LeadsViewSuccessNotifier extends StateNotifier<bool> {
  LeadsViewSuccessNotifier() : super(false); // Initialize with false

  void setLeadsViewSuccess(bool value) {
    debugPrint('4. Setting leads view success: $value'); // Debug point 4
    state = value;
  }
}
