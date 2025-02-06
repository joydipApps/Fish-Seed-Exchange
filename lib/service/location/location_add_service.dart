import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/location/location_add_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LocationAddService {
  final String baseUrl = Urls.addLocationDataEndPoint;

  Future<LocationAddModel?> addLocationData(
      BuildContext context, LocationAddModel locationData) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(locationData.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic locationDetails = responseData['Details'];

          if (locationDetails != null &&
              locationDetails is Map<String, dynamic>) {
            final locationModel = LocationAddModel.fromJson(locationDetails);

            debugPrint('Response Body locationId: ${locationModel.locationId}');
            debugPrint('Response Body userPhone: ${locationModel.userPhoneNo}');
            debugPrint('Response Body: ${response.body}');
            debugPrint('Request URL: $baseUrl');
            debugPrint('Response Status Code: ${response.statusCode}');
            // showSnackDialog(context, 1, "Data Saved successfully.");
            return locationModel;
          } else {
            debugPrint(
                'Error: UserDetails is null or not a Map<String, dynamic>');
            return null;
          }
        } else {
          debugPrint(
              'Error: Response body does not contain expected data structure');
          return null;
        }
      } else {
        debugPrint('API Error: ${response.body}');
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException catch (e) {
      debugPrint('Network Error: $e');
      return null;
    } on FormatException catch (e) {
      debugPrint('Format Error: $e');

      // showSnackDialog(context, 2, "Format Error, try later.");
      return null;
    } catch (e) {
      debugPrint('Unknown Error: $e');
      // showSnackDialog(context, 2, "Unknown Error, try later.");
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
