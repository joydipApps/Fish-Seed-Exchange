import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/picture/picture_view_model.dart';
import '../../../service/imagery/picture/picture_view_service.dart';

final pictureViewModelProvider =
    StateNotifierProvider<PictureViewModelNotifier, List<PictureViewModel>>(
        (ref) {
  return PictureViewModelNotifier();
});

final pictureViewServiceProvider = Provider<PictureViewService>((ref) {
  return PictureViewService();
});

// return success id wise

final pictureViewSuccessProvider =
    StateNotifierProviderFamily<PictureViewSuccessNotifier, bool, String>(
        (ref, saleId) {
  return PictureViewSuccessNotifier();
});

class PictureViewSuccessNotifier extends StateNotifier<bool> {
  PictureViewSuccessNotifier() : super(false); // Initialize with false

  void setPictureViewSuccess(bool value) {
    state = value;
  }
}

// final pictureViewSuccessProvider =
//     StateNotifierProvider<PictureViewSuccessNotifier, bool>((ref) {
//   return PictureViewSuccessNotifier(); // You'll need to create this notifier class
// });
//
// class PictureViewSuccessNotifier extends StateNotifier<bool> {
//   PictureViewSuccessNotifier() : super(false); // Initialize with false
//
//   void setPictureViewSuccess(bool value) {
//     state = value;
//   }
// }
