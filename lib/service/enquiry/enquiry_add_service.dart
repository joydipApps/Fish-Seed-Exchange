import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/enquiry/enquiry_add_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class EnquiryAddService {
  final String baseUrl = Urls.addEnquiryDataEndPoint;

  Future<EnquiryAddModel?> enquiryAddData(
      BuildContext context, EnquiryAddModel enquiryData) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body:
            jsonEncode(enquiryData.toJson()), // Convert EnquiryAddModel to JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic enquiryDetails = responseData['Details'];

          if (enquiryDetails != null &&
              enquiryDetails is Map<String, dynamic>) {
            final result = EnquiryAddModel.fromJson(enquiryDetails);
            // showSnackDialog(context, 1, "Data Saved successfully.");
            return result;
          } else {
            // showSnackDialog(context, 2, "No data found, try later.");
            return null;
          }
        } else {
          //showSnackDialog(context, 2, "No data found, try later.");
          return null;
        }
      } else {
        if (context.mounted) {
          showSnackDialog(
              context, 2, "Failed to send enquiry. Try again later.");
        }

        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }

      return null;
    } on http.ClientException {
      // showSnackDialog(context, 2, "Client error. Try again later.");
      return null;
    } on FormatException {
      //showSnackDialog(context, 2, "Invalid data format received.");
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown error occurred.");
      }

      return null;
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop(); // Dismiss the loading indicator
      }
    }
  }
}
