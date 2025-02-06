import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/leads/leads_add_model.dart';
import '../../service/leads/leads_add_service.dart';

final leadsAddModelProvider =
    StateNotifierProvider<LeadsAddModelNotifier, List<LeadsAddModel>>((ref) {
  return LeadsAddModelNotifier();
});

final leadsAddServiceProvider = Provider<LeadsAddService>((ref) {
  return LeadsAddService();
});

final leadsAddSuccessProvider =
    StateNotifierProvider<LeadsAddSuccessNotifier, bool>((ref) {
  return LeadsAddSuccessNotifier(); // You'll need to create this notifier class
});

class LeadsAddSuccessNotifier extends StateNotifier<bool> {
  LeadsAddSuccessNotifier() : super(false); // Initialize with false

  void setLeadsAddSuccess(bool value) {
    state = value;
  }
}
