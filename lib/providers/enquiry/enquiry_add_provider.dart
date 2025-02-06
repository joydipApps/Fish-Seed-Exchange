import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enquiry/enquiry_add_model.dart';
import '../../service/enquiry/enquiry_add_service.dart';

final enquiryAddModelProvider =
    StateNotifierProvider<EnquiryAddModelNotifier, List<EnquiryAddModel>>(
        (ref) {
  return EnquiryAddModelNotifier();
});

final enquiryAddServiceProvider = Provider<EnquiryAddService>((ref) {
  return EnquiryAddService();
});

final enquiryAddSuccessProvider =
    StateNotifierProvider<EnquiryAddSuccessNotifier, bool>((ref) {
  return EnquiryAddSuccessNotifier(); // You'll need to create this notifier class
});

class EnquiryAddSuccessNotifier extends StateNotifier<bool> {
  EnquiryAddSuccessNotifier() : super(false); // Initialize with false

  void setEnquiryAddSuccess(bool value) {
    state = value;
  }
}
