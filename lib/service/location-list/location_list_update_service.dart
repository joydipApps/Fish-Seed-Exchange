import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/location-list/location_list_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LocationUpdateService {
  final String baseUrl = Urls.viewLocationDataEndPoint;

  Future<LocationListModel?> updateLocationData({
    required BuildContext context,
    required String locationId,
  }) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({
          "req_type": "location_id",
          "req_value": locationId,
        }),
      );

      // Print the raw response body for debugging
      debugPrint('Response Body: ${response.body}');
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Request URL: $baseUrl');

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        debugPrint('Decoded API Response: $responseData');

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic locationDetails = responseData['Details'];

          if (locationDetails != null && locationDetails is List) {
            if (locationDetails.isNotEmpty &&
                locationDetails[0] is Map<String, dynamic>) {
              final locationModel =
                  LocationListModel.fromJson(locationDetails[0]);

              // showSnackDialog(context, 1, "Data Saved successfully.");
              return locationModel;
            } else {
              debugPrint(
                  'LocationUpdateService Error: Details list is empty or not a list of Map<String, dynamic>');
              // showSnackDialog(context, 2, "Unexpected data format.");
              return null;
            }
          } else {
            debugPrint(
                'LocationUpdateService Error: Details is null or not a List');
            // showSnackDialog(context, 2, "Unexpected data format.");
            return null;
          }
        } else {
          debugPrint(
              'LocationUpdateService Error: Response body does not contain expected data structure');
          // showSnackDialog(context, 2, "Unexpected data structure.");
          return null;
        }
      } else {
        debugPrint('LocationUpdateService API Error: ${response.body}');
        // showSnackDialog(context, 2, "API Error, try later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException catch (e) {
      debugPrint('LocationUpdateService Network Error: $e');
      // showSnackDialog(context, 2, "Network Error, try later.");
      return null;
    } on FormatException catch (e) {
      debugPrint('LocationUpdateService Format Error: $e');
      // showSnackDialog(context, 2, "Format Error, try later.");
      return null;
    } catch (e) {
      debugPrint('LocationUpdateService Unknown Error: $e');
      // showSnackDialog(context, 2, "Unknown Error, try later.");
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
