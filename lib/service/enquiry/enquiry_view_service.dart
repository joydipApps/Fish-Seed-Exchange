import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/enquiry/enquiry_view_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class EnquiryViewService {
  final String baseUrl = Urls.viewEnquiryDataEndPoint;

  Future<List<EnquiryViewModel>?> enquiryViewDetails({
    required BuildContext context,
  }) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        // body: jsonEncode({}),

        // {"req_type":"user_phno", "req_value":"9831077172"}
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['Details'] != null) {
          final List<dynamic> details = responseData['Details'];
          // TODO update 8june
          // final List<EnquiryViewModel> enquiryViewModels =
          //     details.map(EnquiryViewModel.fromJson).toList();

          final List<EnquiryViewModel> enquiryViewModels = details
              .map<EnquiryViewModel>((item) =>
                  EnquiryViewModel.fromJson(item as Map<String, dynamic>))
              .toList();

          debugPrint('enquiryViewDetails : Valid data return');
          // displaySnackBar(context, 1, "Data Saved successfully.");
          return enquiryViewModels;
        } else {
          //showSnackDialog(context, 2, "Data not valid.");
          return null;
        }
      } else {
        if (context.mounted) {
          showSnackDialog(context, 2, "Network Error");
        }

        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }

      return null;
    } on http.ClientException catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Network Error.");
      }

      return null;
    } on FormatException catch (e) {
      debugPrint('enquiryViewDetails : FormatException: $e');
      //showSnackDialog(context, 2, "Format Error.");
      return null;
    } catch (e) {
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error.");
      }

      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
