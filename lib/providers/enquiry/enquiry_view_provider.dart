import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enquiry/enquiry_view_model.dart';
import '../../service/enquiry/enquiry_view_service.dart';

final enquiryViewModelProvider =
    StateNotifierProvider<EnquiryViewModelNotifier, List<EnquiryViewModel>>(
        (ref) {
  debugPrint('1. Creating enquiryViewModelProvider'); // Debug point 1
  return EnquiryViewModelNotifier();
});

// no of records count
final enquiryCountProvider = Provider<int>((ref) {
  final enquiryCount = ref.watch(enquiryViewModelProvider);
  return enquiryCount.length; // Count the number of seed sales
});

final enquiryViewServiceProvider = Provider<EnquiryViewService>((ref) {
  debugPrint('2. Creating enquiryViewServiceProvider'); // Debug point 2
  return EnquiryViewService();
});

final enquiryViewSuccessProvider =
    StateNotifierProvider<EnquiryViewSuccessNotifier, bool>((ref) {
  debugPrint('3. Creating enquiryViewSuccessProvider'); // Debug point 3
  return EnquiryViewSuccessNotifier(); // You'll need to create this notifier class
});

class EnquiryViewSuccessNotifier extends StateNotifier<bool> {
  EnquiryViewSuccessNotifier() : super(false); // Initialize with false

  void setEnquiryViewSuccess(bool value) {
    debugPrint('4. Setting enquiry view success: $value'); // Debug point 4
    state = value;
  }
}
