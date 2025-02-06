import '../../service/pin-code/pin_code_data_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pinCodeDataServiceProvider = Provider<PinCodeDataService>((ref) {
  return PinCodeDataService();
});
