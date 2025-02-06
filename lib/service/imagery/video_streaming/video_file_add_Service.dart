import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import '../../../models/imagery/video/video_file_add_model.dart';
import '../../../routes/http_urls.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';

class VideoFileAddService {
  final String baseUrl = Urls.sendVideoFilesEndPoint;

  Future<VideoFileAddModel?> saveVideoFile({
    required BuildContext context,
    required VideoFileAddModel addVideo,
  }) async {
    showProgressDialogSync(context); // Show loading indicator
    debugPrint('Show progress dialog');
    try {
      final url = Uri.parse(baseUrl);
      debugPrint('Request URL: $url');

      final request = http.MultipartRequest('POST', url);
      debugPrint('Adding fields...');
      request.fields['video_id'] = addVideo.videoId;
      request.fields['sale_id'] = addVideo.saleId;
      request.fields['user_phno'] = addVideo.userPhNo;
      debugPrint('Fields added: ${request.fields}');

      // Attach the video file
      if (await addVideo.videoFile.exists()) {
        debugPrint('Attaching video file: ${addVideo.videoFile.path}');
        request.files.add(await http.MultipartFile.fromPath(
          'file',
          addVideo.videoFile.path,
          contentType: MediaType(
              'video', path.extension(addVideo.videoFile.path).substring(1)),
        ));
        debugPrint('Video file attached: ${request.files.first.filename}');
      } else {
        debugPrint(
            'Video file does not exist at path: ${addVideo.videoFile.path}');
        if (context.mounted) {
          showSnackDialog(context, 5, "Video file not found.");
        }
        return null;
      }

      debugPrint('Sending request...');
      request.headers.forEach((key, value) => debugPrint('$key: $value'));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint(
          'VideoAddService Response Status Code: ${response.statusCode}');
      debugPrint('VideoAddService Response Headers: ${response.headers}');
      debugPrint('VideoAddService Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        debugPrint('VideoAddService Response Data: $responseData');

        if (responseData != null && responseData['Details'] != null) {
          final Map<String, dynamic> details = responseData['Details'];
          final VideoFileAddModel mediaFile =
              VideoFileAddModel.fromJson(details);
          debugPrint('Media File: $mediaFile');

          if (context.mounted) {
            showSnackDialog(context, 1, "Data Saved successfully.");
          }
          return mediaFile;
        } else {
          // if (context.mounted) {
          //   showSnackDialog(context, 5, "Data not found");
          // }
          debugPrint('VideoAddService Data not found');
          return null;
        }
      } else {
        // if (context.mounted) {
        //   showSnackDialog(context, 5, "Data not found");
        // }
        debugPrint('VideoAddService API Error: ${response.body}');
        return null;
      }
    } on SocketException {
      debugPrint('VideoAddService SocketException: Network error');
      if (context.mounted) {
        showSnackDialog(
            context, 5, "Network error. Please check your connection.");
      }
      return null;
    } on http.ClientException {
      debugPrint('VideoAddService ClientException: Client error');
      // if (context.mounted) {
      //   showSnackDialog(context, 5, "Client error. Try again later.");
      // }
      return null;
    } on FormatException {
      debugPrint('VideoAddService FormatException: Invalid data format');
      // if (context.mounted) {
      //   showSnackDialog(context, 5, "Invalid data format received.");
      // }
      return null;
    } catch (e) {
      debugPrint('VideoAddService Unknown error: $e');
      if (context.mounted) {
        showSnackDialog(context, 5, "Unknown error occurred.");
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
        debugPrint('VideoAddService Dismissed progress dialog');
      } // Dismiss the loading indicator
    }
  }
}
