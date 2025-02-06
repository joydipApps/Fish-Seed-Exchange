import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/location/location_view_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LocationViewService {
  final String baseUrl = Urls.viewLocationDataEndPoint;

  Future<LocationViewModel?> viewLocationData({
    required BuildContext context,
    required String reqType,
    required String reqValue,
  }) async {
    showProgressDialogSync(context); // Show loading indicator
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({"req_type": reqType, "req_value": reqValue}),
      );

      // Print request details
      debugPrint('Request URL: $baseUrl');
      debugPrint('Request Headers: ${response.request?.headers}');
      debugPrint('Request Body: ${jsonEncode({
            "req_type": reqType,
            "req_value": reqValue
          })}');

      // Print response details
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null) {
          debugPrint('Decoded Response Data: $responseData');

          if (responseData.containsKey('Details')) {
            final dynamic locationDetails = responseData['Details'];
            debugPrint('Location Details: $locationDetails');

            if (locationDetails != null) {
              if (locationDetails is List<dynamic>) {
                // Handle case where Details is a list
                if (locationDetails.isNotEmpty) {
                  final locationModel =
                      LocationViewModel.fromJson(locationDetails[0]);
                  debugPrint('Parsed Location Model: $locationModel');
                  // showSnackDialog(context, 1, "Data retrieved successfully.");
                  return locationModel;
                } else {
                  debugPrint('Error: Details list is empty');
                  // showSnackDialog(context, 2, "Details list is empty.");
                  return null;
                }
              } else if (locationDetails is Map<String, dynamic>) {
                // Handle case where Details is a single object
                final locationModel =
                    LocationViewModel.fromJson(locationDetails);
                debugPrint('Parsed Location Model: $locationModel');
                //  showSnackDialog(context, 1, "Data retrieved successfully.");
                return locationModel;
              } else {
                debugPrint('Error: Details is not a Map or List');
                // showSnackDialog(context, 2, "Data format error.");
                return null;
              }
            } else {
              debugPrint('Error: Details is null');
              // showSnackDialog(context, 2, "No details found.");
              return null;
            }
          } else if (responseData.containsKey('message') &&
              responseData.containsKey('status')) {
            debugPrint('Error: ${responseData['message']}');
            // showSnackDialog(context, 2, responseData['message']);
            return null;
          } else {
            debugPrint('Error: Response data does not contain expected keys');
            // showSnackDialog(context, 2, "Unexpected response format.");
            return null;
          }
        } else {
          debugPrint('Error: Response data is null');
          // showSnackDialog(context, 2, "No data found.");
          return null;
        }
      } else {
        debugPrint('API Error: ${response.body}');
        // showSnackDialog(context, 2, "Data not found, try later.");
        return null;
      }
    } on http.ClientException catch (e) {
      debugPrint('Network Error: $e');
      // showSnackDialog(context, 2, "Network error, try later.");
      return null;
    } on FormatException catch (e) {
      debugPrint('Format Error: $e');
      // showSnackDialog(context, 2, "Format error, try later.");
      return null;
    } catch (e) {
      debugPrint('Unknown Error: $e');
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown error, try later.");
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
