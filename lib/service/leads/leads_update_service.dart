import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/leads/leads_view_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LeadsUpdateService {
  final String baseUrl = Urls.updateLeadsDataEndPoint;

  Future<List<LeadsViewModel>?> leadsUpdateDetails({
    required BuildContext context,
    required String leadsId,
  }) async {
    debugPrint(
        'LeadsUpdateService: Starting leadsUpdateDetails'); // Debug point 1

    // Show the loading dialog
    showProgressDialogSync(context); // Show loading indicator

    try {
      debugPrint(
          'LeadsUpdateService: Sending request to $baseUrl'); // Debug point 2

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({'leads_id': leadsId}),
      );

      debugPrint(
          'LeadsUpdateService: Received response with status code ${response.statusCode}'); // Debug point 3

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        debugPrint(
            'LeadsUpdateService: Response data: $responseData'); // Debug point 4

        if (responseData != null && responseData['Details'] != null) {
          debugPrint(
              'LeadsUpdateService: Parsing response data'); // Debug point 5

          final List<dynamic> details = responseData['Details'];
          // TODO  update June8
          // final List<LeadsViewModel> leadsData =
          //     details.map(LeadsViewModel.fromJson).toList();
          final List<LeadsViewModel> leadsData = details
              .map<LeadsViewModel>((item) =>
                  LeadsViewModel.fromJson(item as Map<String, dynamic>))
              .toList();
          debugPrint(
              'LeadsUpdateService: Parsed ${leadsData.length} leads'); // Debug point 6

          return leadsData;
        } else {
          debugPrint(
              'LeadsUpdateService: No data found in response'); // Debug point 7
          // showSnackDialog(context, 2, "No data found, try later.");
          return null;
        }
      } else {
        debugPrint(
            'LeadsUpdateService: Response status not 200'); // Debug point 8
        // showSnackDialog(context, 2, "No data found, try later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Check your connection.");
      } // Debug point 9
      return null;
    } on http.ClientException catch (e) {
      debugPrint('LeadsUpdateService: Network Error: $e'); // Debug point 10
      // showSnackDialog(context, 2, "Network Error, try later.");
      return null;
    } on FormatException catch (e) {
      debugPrint('LeadsUpdateService: Format Error: $e'); // Debug point 11
      // showSnackDialog(context, 2, "Format Error, try later.");
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error, try later.");
      } // Debug point 12
      return null;
    } finally {
      // Debug point 13
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
