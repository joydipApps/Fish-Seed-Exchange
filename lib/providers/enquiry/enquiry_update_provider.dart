import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enquiry/enquiry_view_model.dart';
import '../../service/enquiry/enquiry_update_service.dart';

final enquiryUpdateModelProvider =
    StateNotifierProvider<EnquiryViewModelNotifier, List<EnquiryViewModel>>(
        (ref) {
  debugPrint('1. Creating enquiryUpdateModelProvider'); // Debug point 1
  return EnquiryViewModelNotifier();
});

final enquiryUpdateServiceProvider = Provider<EnquiryUpdateService>((ref) {
  debugPrint('2. Creating enquiryUpdateServiceProvider'); // Debug point 2
  return EnquiryUpdateService();
});

final enquiryUpdateSuccessProvider =
    StateNotifierProvider<EnquiryUpdateSuccessNotifier, bool>((ref) {
  debugPrint('3. Creating enquiryUpdateSuccessProvider'); // Debug point 3
  return EnquiryUpdateSuccessNotifier(); // You'll need to create this notifier class
});

class EnquiryUpdateSuccessNotifier extends StateNotifier<bool> {
  EnquiryUpdateSuccessNotifier() : super(false); // Initialize with false

  void setEnquiryUpdateSuccess(bool value) {
    debugPrint('4. Setting enquiry Update success: $value'); // Debug point 4
    state = value;
  }
}
