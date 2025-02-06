import 'dart:convert';
import 'dart:io';
import '../../../models/imagery/picture/picture_add_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../routes/http_urls.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';

class PictureAddService {
  final String baseUrl = Urls.sendMediaFilesEndPoint;

  Future<Map<String, dynamic>?> savePictureDetails({
    required BuildContext context,
    required PictureAddModel addPicture,
  }) async {
    debugPrint(
        'PictureAddService savePictureDetails called with PictureAddModel: $addPicture');
    showProgressDialogSync(context); // Show loading indicator

    try {
      final url = Uri.parse(baseUrl);
      debugPrint('Request URL: $url');
      final headers = {HttpHeaders.contentTypeHeader: "application/json"};
      final body = jsonEncode({
        'media_id': addPicture.pictureId,
        'sale_id': addPicture.saleId,
        'user_phno': addPicture.userPhNo,
        'type': 'picture',
        'base64_value': addPicture.pictureBase64,
      });
      debugPrint('PictureAddService Request Headers: $headers');
      debugPrint('PictureAddService Request Body: $body');

      final response = await http.post(url, headers: headers, body: body);

      debugPrint(
          'PictureAddService Response Status Code: ${response.statusCode}');
      debugPrint('PictureAddService Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        showSnackDialog(context, 1, "Data Saved successfully.");
        return responseData;
      } else {
        // if (context.mounted) {
        //   showSnackDialog(context, 5, "Data not found");
        // }

        debugPrint('PictureAddService API Error: ${response.body}');
        return null;
      }
    } on SocketException {
      debugPrint('PictureAddService Network error: SocketException');
      // showSnackDialog(
      //     context, 5, "Network error. Please check your connection.");
      return null;
    } on http.ClientException {
      debugPrint('PictureAddService Client error: http.ClientException');
      // showSnackDialog(context, 5, "Client error. Try again later.");
      return null;
    } on FormatException {
      debugPrint('PictureAddService Invalid data format: FormatException');
      // showSnackDialog(context, 5, "Invalid data format received.");
      return null;
    } catch (e) {
      debugPrint('PictureAddService Unknown error: $e');
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
