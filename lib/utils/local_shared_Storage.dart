import 'package:shared_preferences/shared_preferences.dart';

import '../providers/local_storage/phone_number_provider.dart';
import '../providers/local_storage/phoneno_presence_provider.dart';

class LocalSharedStorage {
  static Future<SharedPreferences> _getInstance() async =>
      await SharedPreferences.getInstance();

  static Future<void> setUser({
    required String phoneNo,
    required String name,
    required String userType,
    PhoneNoNotifier? phoneNoNotifier,
    PhoneNoPresenceNotifier? phoneNoPresenceNotifier,
  }) async {
    if (phoneNo.isNotEmpty && name.isNotEmpty && userType.isNotEmpty) {
      final prefs = await _getInstance();
      final String? storedPhoneNo = prefs.getString('phoneNo');

      if (storedPhoneNo == null) {
        await prefs.setString('phoneNo', phoneNo);
        await prefs.setString('name', name);
        await prefs.setString('userType', userType);
      } else if (storedPhoneNo == phoneNo) {
        await prefs.setString('name', name);
        await prefs.setString('userType', userType);
      } else {
        await prefs.clear();
        await prefs.setString('phoneNo', phoneNo);
        await prefs.setString('name', name);
        await prefs.setString('userType', userType);
      }

      phoneNoNotifier?.setNumber(phoneNo); // Update phone number notifier
      phoneNoPresenceNotifier?.setPresence(true); // Set presence to true
    } else {
      throw Exception('Phone number, name, and user type cannot be blank.');
    }
  }

  static Future<List<String>> getUser() async {
    final prefs = await _getInstance();
    String name = prefs.getString("name") ?? "";
    String phoneNo = prefs.getString("phoneNo") ?? "";
    String userType = prefs.getString("userType") ?? "";
    return [name, phoneNo, userType];
  }

  static Future<void> setName({required String name}) async {
    final prefs = await _getInstance();
    await prefs.setString("name", name);
  }

  static Future<String> getName() async {
    final prefs = await _getInstance();
    String data = prefs.getString("name") ?? "";
    return data;
  }

  static Future<void> setPhoneNo(String phNo) async {
    final prefs = await _getInstance();
    await prefs.setString("phoneNo", phNo);
  }

  static Future<String> getPhoneNo() async {
    final prefs = await _getInstance();
    String data = prefs.getString("phoneNo") ?? "";
    return data;
  }

  static Future<void> setUserType(String userType) async {
    final prefs = await _getInstance();
    await prefs.setString("userType", userType);
  }

  static Future<String> getUserType() async {
    final prefs = await _getInstance();
    String data = prefs.getString("userType") ?? "";
    return data;
  }
}
