import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/location-list/location_list_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LocationListService {
  final String baseUrl = Urls.viewLocationDataEndPoint;

  Future<List<LocationListModel>?> listLocationData({
    required BuildContext context,
    required String phone_no,
  }) async {
    showProgressDialogSync(context); // Show loading indicator
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({
          "req_type": "user_phno",
          "req_value": phone_no,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null) {
          if (responseData.containsKey('Details')) {
            final dynamic addressList = responseData['Details'];

            if (addressList is List<dynamic>) {
              return LocationListModel.listFromJson(addressList);
            } else {
              // showSnackDialog(context, 2, "No Data, try later.");
              return null;
            }
          } else {
            // showSnackDialog(context, 2, "No Data, try later.");
            return null;
          }
        } else {
          // showSnackDialog(context, 2, "No Data, try later.");
          return null;
        }
      } else {
        // showSnackDialog(context, 2, "API Error, try later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException {
      // showSnackDialog(context, 2, "Network Error, try later.");
      return null;
    } on FormatException {
      // showSnackDialog(context, 2, "Format Error, try later.");
      return null;
    } catch (e) {
      // showSnackDialog(context, 2, "Unknown Error, try later.");
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
