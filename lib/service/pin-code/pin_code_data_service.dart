import 'dart:convert';
import 'dart:io';
import '../../utils/show_snack_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';

class PinCodeDataService {
  final String baseUrl = Urls.getPinCodeDataEndPoint;

  Future<List<Map<String, dynamic>>?> getData(
      BuildContext context, String pinCode) async {
    // Show loading indicator
    showProgressDialogSync(context); // Show loading indicator

    final url = "$baseUrl/$pinCode";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Status'] == 'Error') {
          if (context.mounted) {
            showSnackDialog(context, 5, "Pin Code is not valid.");
          }
          return null;
        } else {
          final postOfficeArray = jsonResponse['PostOffice'] as List;

          if (postOfficeArray.isEmpty) {
            if (context.mounted) {
              showSnackDialog(context, 2, "No data found for this Pin Code.");
            }
            return null;
          }

          // Return the list of post offices
          return postOfficeArray.cast<Map<String, dynamic>>();
        }
      } else {
        if (context.mounted) {
          showSnackDialog(
              context, 5, "Failed to fetch data. Please try again.");
        }
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 5, "Please check your connection.");
      }
      return null;
    } on http.ClientException {
      if (context.mounted) {
        showSnackDialog(context, 5, "Client error. Try again later.");
      }
      return null;
    } on FormatException {
      if (context.mounted) {
        showSnackDialog(context, 5, "Invalid data format received.");
      }
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 6, 'Error occurred. Please try again.');
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      } // Dismiss the loading indicator
    }
  }
}
