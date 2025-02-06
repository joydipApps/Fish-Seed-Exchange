import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterUserModel {
  String userPhNo;
  String userName;
  String userType;

  RegisterUserModel({
    required this.userPhNo,
    required this.userName,
    required this.userType,
  });

  factory RegisterUserModel.fromJson(Map<String, dynamic> jsonData) {
    return RegisterUserModel(
      userPhNo: jsonData["user_phno"] ?? "",
      userName: jsonData["user_name"] ?? "",
      userType: jsonData["user_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_phno"] = userPhNo;
    data["user_name"] = userName;
    data["user_type"] = userType;
    return data;
  }
}

class RegisterUserModelNotifier extends StateNotifier<RegisterUserModel?> {
  RegisterUserModelNotifier() : super(null);

  void updateUser(RegisterUserModel newUser) {
    state = newUser;
  }

  void addUser(RegisterUserModel newUser) {
    final updatedUser = RegisterUserModel(
      userPhNo: newUser.userPhNo,
      userName: newUser.userName,
      userType: newUser.userType,
    );
    state = updatedUser;
  }
}
