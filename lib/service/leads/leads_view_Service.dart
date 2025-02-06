import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/leads/leads_view_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class LeadsViewService {
  final String baseUrl = Urls.viewLeadsDataEndPoint;

  Future<List<LeadsViewModel>?> leadsViewDetails({
    required BuildContext context,
    required String userPhNo,
  }) async {
    // Show the loading dialog
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json.encode({"user_phno": userPhNo}),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['Details'] != null) {
          debugPrint('4. Parsing response data'); // Debug point 4

          final List<dynamic> details = responseData['Details'];
          // final List<LeadsViewModel> leadsViewModels =
          //     details.map(LeadsViewModel.fromJson).toList();
          // TODO  update June8
          final List<LeadsViewModel> leadsViewModels = details
              .map<LeadsViewModel>((item) =>
                  LeadsViewModel.fromJson(item as Map<String, dynamic>))
              .toList();

          // displaySnackBar(context, 1, "Data Saved successfully.");
          return leadsViewModels;
        } else {
          // showSnackDialog(context, 2, "No data found, try later.");
          return null;
        }
      } else {
        // showSnackDialog(context, 2, "No data found, try later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException catch (e) {
      debugPrint('10. Network Error: $e'); // Debug point 10
      // showSnackDialog(context, 2, "Network Error, try later.");
      return null;
    } on FormatException catch (e) {
      // showSnackDialog(context, 2, "Format Error, try later.");
      debugPrint('11. Format Error: $e'); // Debug point 11
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error, try later.");
      }
      debugPrint('12. Unknown Error: $e'); // Debug point 12
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
