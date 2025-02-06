import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/picture/picture_add_model.dart';
import '../../../service/imagery/picture/picture_add_service.dart';

final pictureAddModelProvider =
    StateNotifierProvider<PictureAddModelNotifier, List<PictureAddModel>>(
  (ref) => PictureAddModelNotifier(),
);

final pictureAddServiceProvider =
    Provider<PictureAddService>((ref) => PictureAddService());

// Return success id-wise
final pictureAddSuccessProvider =
    StateNotifierProvider.family<PictureAddSuccessNotifier, bool, String>(
  (ref, pictureId) => PictureAddSuccessNotifier(pictureId),
);

class PictureAddSuccessNotifier extends StateNotifier<bool> {
  final String pictureId;

  PictureAddSuccessNotifier(this.pictureId)
      : super(false); // Initialize with false

  void setPictureAddSuccess(bool value) {
    state = value;
  }
}
