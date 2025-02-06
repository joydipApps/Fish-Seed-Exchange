// get_mobile_number.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_number/mobile_number.dart';

Future<String?> getMobileNumber() async {
  final status = await Permission.phone.request();
  if (status.isGranted) {
    final mobileNumber = await MobileNumber.mobileNumber;
    debugPrint("Mobile no $mobileNumber");
    return mobileNumber;
  } else {
    debugPrint("Permission Denied");
    // Handle permission denied case (e.g., show a message)

    return null;
  }
}
