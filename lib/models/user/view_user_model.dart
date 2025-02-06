import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewUserModel {
  int userId;
  String userName;
  String userPhNo;
  String userType;

  ViewUserModel({
    required this.userId,
    required this.userName,
    required this.userPhNo,
    required this.userType,
  });

  factory ViewUserModel.fromJson(Map<String, dynamic> json) {
    return ViewUserModel(
      userId: int.tryParse(json["user_id"].toString()) ?? 0,
      userName: json["user_name"] ?? "",
      userPhNo: json["user_phno"] ?? "",
      userType: json["user_type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = userId;
    data["user_name"] = userName;
    data["user_phno"] = userPhNo;
    data["user_type"] = userType;
    return data;
  }
}

class ViewUserModelNotifier extends StateNotifier<ViewUserModel?> {
  ViewUserModelNotifier() : super(null);

  void updateUser(ViewUserModel newUser) {
    state = newUser;
  }

  void addUser(ViewUserModel newUser) {
    final updatedUser = ViewUserModel(
      userId: newUser.userId,
      userName: newUser.userName,
      userPhNo: newUser.userPhNo,
      userType: newUser.userType,
    );
    state = updatedUser;
  }
}
