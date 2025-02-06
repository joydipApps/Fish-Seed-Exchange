import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LocationRemoveService {
  final String baseUrl = Urls.removeLocationDataEndPoint;

  Future<bool> removeLocationData(
      BuildContext context, WidgetRef ref, String locationId) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json.encode({"location_id": locationId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null && responseData['Status'] == "200") {
          dynamic locationViewModelNotifierProvider;
          final locationNotifier =
              ref.read(locationViewModelNotifierProvider.notifier);
          locationNotifier
              .removeLocation(locationId); // Remove location from model

          debugPrint('Response Body: ${response.body}');
          debugPrint('Request URL: $baseUrl');
          debugPrint('Response Status Code: ${response.statusCode}');
          // showSnackDialog(context, 1, "Data removed successfully.");
          return true;
        } else {
          debugPrint('Error: Unexpected response format');
          // showSnackDialog(context, 2, "Unexpected response format.");
          return false;
        }
      } else {
        debugPrint('API Error: ${response.body}');
        // showSnackDialog(context, 2, "API Error: ${response.body}");
        return false;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return false;
    } on http.ClientException catch (e) {
      debugPrint('Network Error: $e');
      // showSnackDialog(context, 2, "Network Error, try later.");
      return false;
    } on FormatException catch (e) {
      debugPrint('Format Error: $e');
      // showSnackDialog(context, 2, "Format Error, try later.");
      return false;
    } catch (e) {
      debugPrint('Unknown Error: $e');
      // if (context.mounted) {
      //   showSnackDialog(context, 2, "Unknown Error, try later.");
      // }

      return false;
    } finally {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
