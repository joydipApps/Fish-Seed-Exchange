import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/location-list/default_location_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class DefaultLocationService {
  final String baseUrl = Urls.defaultLocationUpdateEndPoint;

  Future<DefaultLocationModel?> addDefaultLocationData(
      BuildContext context, DefaultLocationModel DefaultData) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(
            DefaultData.toJson()), // Use DefaultData instead of enquiryData
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic responseDetails = responseData['Details'];

          if (responseDetails != null &&
              responseDetails is Map<String, dynamic>) {
            final result = DefaultLocationModel.fromJson(
                responseDetails); // Use responseDetails instead of enquiryDetails
            // showSnackDialog(context, 1, "Data saved successfully.");
            return result;
          } else {
            // showSnackDialog(context, 2, "No data found. Try again later.");
            return null;
          }
        } else {
          // showSnackDialog(context, 2, "No data found. Please try again later.");
          return null;
        }
      } else {
        // showSnackDialog(context, 2, "Failed to send enquiry. Try again later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException {
      // showSnackDialog(context, 2, "Client error. Please try again later.");
      return null;
    } on FormatException {
      // showSnackDialog(context, 2, "Invalid data format received.");
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown error occurred.");
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      } // Dismiss the loading indicator
    }
  }
}
