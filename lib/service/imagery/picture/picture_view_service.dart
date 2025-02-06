import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/imagery/picture/picture_view_model.dart';
import '../../../routes/http_urls.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';

class PictureViewService {
  final String baseUrl = Urls.getMediaFilesEndPoint;

  Future<List<PictureViewModel>?> getPictureDetails({
    required BuildContext context,
    required String saleId,
  }) async {
    debugPrint('getPictureDetails called with saleId: $saleId');
    showProgressDialogSync(context); // Show loading indicator

    try {
      final url = Uri.parse(baseUrl);
      debugPrint('Request URL: $url');
      final headers = {HttpHeaders.contentTypeHeader: "application/json"};
      final body = jsonEncode({
        'sale_id': saleId,
        'type': 'picture',
      });
      debugPrint('Request Headers: $headers');
      debugPrint('Request Body: $body');

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        debugPrint('Response Data: $responseData');

        if (responseData != null && responseData['Details'] != null) {
          final List<dynamic> details = responseData['Details'];
          debugPrint('Details: $details');
          final List<PictureViewModel> mediaFiles = details
              .map<PictureViewModel>((item) =>
                  PictureViewModel.fromJson(item as Map<String, dynamic>))
              .toList();

          debugPrint('Media Files: $mediaFiles');
          return mediaFiles;
        } else {
          // showSnackDialog(context, 5, "Data not found");
          debugPrint('Error: Data not found.');
          return null;
        }
      } else {
        // showSnackDialog(context, 5, "Data not found");
        debugPrint('API Error: ${response.body}');
        return null;
      }
    } on SocketException {
      debugPrint('Network error: SocketException');
      if (context.mounted) {
        showSnackDialog(context, 5, "Network error. Check your connection.");
      }

      return null;
    } on http.ClientException {
      debugPrint('Client error: http.ClientException');
      // showSnackDialog(context, 5, "Client error. Try again later.");
      return null;
    } on FormatException {
      debugPrint('Invalid data format: FormatException');
      // showSnackDialog(context, 5, "Invalid data format received.");
      return null;
    } catch (e) {
      debugPrint('Unknown error: $e');
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
