import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/user/register_user_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class RegisterUserService {
  final String baseUrl = Urls.registerUserEndPoint;

  Future<RegisterUserModel?> registerUser(
    BuildContext context,
    String userPhNo,
    String userName,
    String userType,
  ) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({
          "user_phno": userPhNo,
          "user_name": userName,
          "user_type": userType,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic userDetails = responseData['Details'];

          if (userDetails != null && userDetails is Map<String, dynamic>) {
            final vUsermodel = RegisterUserModel.fromJson(userDetails);
            showSnackDialog(context, 1, "Data Saved successfully.");
            return vUsermodel;
          } else {
            debugPrint(
                'Error: UserDetails is null or not a Map<String, dynamic>');
            // showSnackDialog(context, 2, "No data found, try later.");
            return null;
          }
        } else {
          debugPrint(
              'Error: Response body does not contain expected data structure');
          // showSnackDialog(context, 2, "No data found, try later.");
          return null;
        }
      } else {
        debugPrint('1 - API Error: ${response.body}');
        // showSnackDialog(context, 2, "No data found, try later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException catch (e) {
      debugPrint('Network Error: $e');
      // showSnackDialog(context, 2, "Network Error.");
      return null;
    } on FormatException catch (e) {
      debugPrint('Format Error: $e');
      // showSnackDialog(context, 2, "Format Error.");
      return null;
    } catch (e) {
      debugPrint('Unknown Error: $e');
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error.");
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
