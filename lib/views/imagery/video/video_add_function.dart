import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/imagery/video/video_file_add_model.dart';
import '../../../providers/imagery/media/video_count_provider.dart';
import '../../../providers/imagery/video/video_file_add_provider.dart';
import '../../../utils/show_progress_dialog.dart';
import '../../../utils/show_snack_dialog.dart';

videoFileAddFunction({
  required BuildContext context,
  required WidgetRef ref,
  required VideoFileAddModel addVideo,
}) async {
  showProgressDialogSync(context); // Show loading indicator

  try {
    final addVideoService = ref.read(videoFileAddServiceProvider);
    final apiResponse = await addVideoService.saveVideoFile(
      context: context,
      addVideo: addVideo,
    );

    if (apiResponse != null) {
      ref.read(saleVideoCounterProvider(addVideo.saleId).notifier).increment();
      if (context.mounted) {
        showSnackDialog(context, 1, 'Record Saving Successful');
      }
    } else {
      if (context.mounted) {
        showSnackDialog(context, 2, 'Record Saving Failure');
      }
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
  } finally {
    if (context.mounted) {
      Navigator.pop(context);
    } // Close the dialog
  }
}

//
//
// Future<void> videoFileAddFunction({
//   required BuildContext context,
//   required WidgetRef ref,
//   required VideoFileAddModel addVideo,
//   required String videoFilePath, // Add this parameter
// }) async {
//   showProgressDialogSync(context); // Show loading indicator
//   debugPrint('Show progress dialog');
//   try {
//     final url = Uri.parse(Urls.sendVideoFilesEndPoint);
//     debugPrint('Request URL: $url');
//
//     final request = http.MultipartRequest('POST', url);
//     request.fields['video_id'] = addVideo.videoId;
//     request.fields['sale_id'] = addVideo.saleId;
//     request.fields['user_phno'] = addVideo.userPhNo;
//
//     // Attach the video file
//     final file = File(addVideo.videoFile);
//     request.files.add(await http.MultipartFile.fromPath(
//       'file',
//       videoFilePath,
//       contentType: MediaType(
//         'video',
//         path.extension(videoFilePath).substring(1),
//       ),
//     ));
//
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);
//
//     debugPrint('VideoAddService Response Status Code: ${response.statusCode}');
//     debugPrint('VideoAddService Response Body: ${response.body}');
//
//     if (response.statusCode == 200) {
//       final dynamic responseData = json.decode(response.body);
//       debugPrint('VideoAddService Response Data: $responseData');
//
//       if (responseData != null && responseData['Details'] != null) {
//         final Map<String, dynamic> details = responseData['Details'];
//         debugPrint('Details: $details');
//
//         showSnackDialog(context, 1, "Data Saved successfully.");
//       } else {
//         showSnackDialog(context, 5, "Data not found");
//         debugPrint('VideoAddService Data not found');
//       }
//     } else {
//       showSnackDialog(context, 5, "Data not found");
//       debugPrint('VideoAddService API Error: ${response.body}');
//     }
//   } on SocketException {
//     debugPrint('VideoAddService SocketException: Network error');
//     showSnackDialog(context, 5, "Network error. Please check your connection.");
//   } on http.ClientException {
//     debugPrint('VideoAddService ClientException: Client error');
//     showSnackDialog(context, 5, "Client error. Try again later.");
//   } on FormatException {
//     debugPrint('VideoAddService FormatException: Invalid data format');
//     showSnackDialog(context, 5, "Invalid data format received.");
//   } catch (e) {
//     debugPrint('VideoAddService Unknown error: $e');
//     showSnackDialog(context, 5, "Unknown error occurred.");
//   } finally {
//     if (context.mounted) {
//       Navigator.pop(context);
//       debugPrint('VideoAddService Dismissed progress dialog');
//     } // Dismiss the loading indicator
//   }
// }
//
//
