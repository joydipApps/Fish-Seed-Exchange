import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user/register_user_model.dart';
import '../../service/user/register_user_service.dart';

final registerUserModelProvider =
    StateNotifierProvider<RegisterUserModelNotifier, RegisterUserModel?>((ref) {
  return RegisterUserModelNotifier();
});

final registerUserServiceProvider = Provider<RegisterUserService>((ref) {
  return RegisterUserService();
});

final registerUserSuccessProvider =
    StateNotifierProvider<RegisterUserSuccessNotifier, bool>((ref) {
  return RegisterUserSuccessNotifier(); // You'll need to create this notifier class
});

class RegisterUserSuccessNotifier extends StateNotifier<bool> {
  RegisterUserSuccessNotifier() : super(false); // Initialize with false

  void setRegisterUserSuccess(bool value) {
    state = value;
  }
}
