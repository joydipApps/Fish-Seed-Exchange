import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/leads/leads_add_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LeadsAddService {
  final String baseUrl = Urls.addLeadsDataEndPoint;

  Future<LeadsAddModel?> leadsAddData(
      BuildContext context, LeadsAddModel leadsData) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(leadsData.toJson()), // Convert LeadsAddModel to JSON
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic leadsData = responseData['Details'];

          if (leadsData != null && leadsData is Map<String, dynamic>) {
            final result = LeadsAddModel.fromJson(leadsData);

            // showSnackDialog(context, 1, "Data Saved successfully.");
            return result;
          } else {
            // showSnackDialog(context, 5, "Data not found");
            return null;
          }
        } else {
          // showSnackDialog(context, 5, "Data not found");
          return null;
        }
      } else {
        // showSnackDialog(context, 5, "Data not found");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 5, "Network error. Check your connection.");
      }

      return null;
    } on http.ClientException {
      // showSnackDialog(context, 5, "Client error. Try again later.");
      return null;
    } on FormatException {
      // showSnackDialog(context, 5, "Invalid data format received.");
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 5, "Unknown error occurred.");
      }

      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      } // Dismiss the loading indicator
    }
  }
}
