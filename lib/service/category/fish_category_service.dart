import 'dart:convert';
import 'dart:io'; // Import this for HttpHeaders
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/fish-category/fish_category_model.dart';
import '../../models/fish-list/fish_list_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class FishCategoryService {
  final String baseUrl = Urls.getFishCategoryEndPoint;

  Future<List<FishCategoryModel>?> fetchFishCategory(
      BuildContext context) async {
    // Show loading dialog
    showProgressDialogSync(context); // Show loading indicator

    try {
      // Make the HTTP request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );

      // Check if response status is OK
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if response contains "Details" key
        if (responseData.containsKey("Details")) {
          final List<dynamic>? details = responseData["Details"];

          if (details != null) {
            final List<FishCategoryModel> fishCategory = details
                .map<FishCategoryModel>((item) =>
                    FishCategoryModel.fromJson(item as Map<String, dynamic>))
                .toList();

            //displaySnackBar(context, 1, "Data Saved successfully.");
            return fishCategory;
          } else {
            return []; // Return null for empty "Details"
          }
        } else {
          return []; // Return null for missing "Details"
        }
      } else {
        return []; // Return null for failed status code
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException catch (e) {
      debugPrint('[F7] Network Error: $e');
      if (context.mounted) {
        showSnackDialog(context, 2, "Network Error, try later.");
      }

      return []; // Return null for network errors
    } on FormatException catch (e) {
      debugPrint('[F8] Format Error: $e');
      if (context.mounted) {
        showSnackDialog(context, 2, "Format Error, try later.");
      }
      return []; // Return null for format errors
    } catch (e) {
      debugPrint('[F9] Unknown Error: $e');
      showSnackDialog(context, 2, "Unknown Error, try later.");

      return []; // Return null for unknown errors
    } finally {
      if (context.mounted) Navigator.of(context).pop();

      // Dismiss the loading indicator
    }
  }
}
