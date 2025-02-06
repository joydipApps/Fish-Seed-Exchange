// import 'dart:io';
// import '../../../models/imagery/video/video_file_add_model.dart';
// import '../../../views/imagery/video/video_add_function.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:path/path.dart' as path;
// import '../../appbar/common_app_bar.dart';
// import 'package:newfish/utils/constants.dart';
//
// class VideoAddPage extends ConsumerStatefulWidget {
//   final String saleId;
//   final String phoneNumber;
//   final int seedVideoCount;
//
//   const VideoAddPage({
//     super.key,
//     required this.saleId,
//     required this.phoneNumber,
//     required this.seedVideoCount,
//   });
//
//   @override
//   VideoAddPageState createState() => VideoAddPageState();
// }
//
// class VideoAddPageState extends ConsumerState<VideoAddPage> {
//   File? _selectedVideo;
//   // String? _selectedVideoName;
//   VideoPlayerController? _videoPlayerController;
//
//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('VideoAddPage Building UI');
//     debugPrint('VideoAddPage _selectedVideo: $_selectedVideo');
//
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'Add Video',
//         isIconBack: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     '#: ${widget.saleId}, Count: ${widget.seedVideoCount}/$kMaxVideo, Size Max $kMaxVideoSizeMB MB'),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     final File? video = await _pickVideoFromGallery(context);
//                     if (video != null) {
//                       await _onVideoSelected(video);
//                     }
//                   },
//                   child: const Text('Select Video from Gallery'),
//                 ),
//               ],
//             ),
//           ),
//           if (_selectedVideo != null)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Center(
//                   child: _videoPlayerController != null &&
//                       _videoPlayerController!.value.isInitialized
//                       ? AspectRatio(
//                     aspectRatio:
//                     _videoPlayerController!.value.aspectRatio,
//                     child: VideoPlayer(_videoPlayerController!),
//                   )
//                       : const CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//           const SizedBox(height: 16.0),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   debugPrint('VideoAddPage Save button pressed');
//
//                   try {
//                     if (_selectedVideo == null) {
//                       debugPrint('VideoAddPage No video selected');
//                       return;
//                     }
//
//                     final addVideo = VideoFileAddModel(
//                       saleId: widget.saleId,
//                       videoId: '',
//                       userPhNo: widget.phoneNumber,
//                       videoFile: _selectedVideo!, // Use non-null assertion
//                     );
//
//                     await videoFileAddFunction(
//                       context: context,
//                       ref: ref,
//                       addVideo: addVideo,
//                     );
//                   } catch (e) {
//                     debugPrint('VideoAddPage Error saving video: $e');
//                   }
//                 },
//                 child: const Text('Save'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<File?> _pickVideoFromGallery(BuildContext context) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickVideo(
//       source: ImageSource.gallery,
//       preferredCameraDevice: CameraDevice.rear,
//     );
//
//     if (pickedFile != null) {
//       final File videoFile = File(pickedFile.path);
//       debugPrint('Video selected: ${videoFile.path}');
//
//       const fileSizeLimit = kMaxVideoSizeMB * 1024 * 1024; // 10 MB in bytes
//
//       if (videoFile.lengthSync() <= fileSizeLimit) {
//         // Generate the video name
//         final now = DateTime.now();
//         final formattedDateTime =
//             '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
//         final extension = path.extension(videoFile.path);
//         // _selectedVideoName =
//         //     '${widget.phoneNumber}_$formattedDateTime$extension';
//         return videoFile;
//       } else {
//         debugPrint('Video file size exceeds limit (10 MB)');
//         if (context.mounted) {
//           _showFileSizeExceededDialog(context);
//         }
//
//         return null;
//       }
//     } else {
//       debugPrint('No video selected.');
//       return null;
//     }
//   }
//
//   void _showFileSizeExceededDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('File Size Exceeded'),
//           content: const Text(
//               'The selected video file exceeds the 10 MB size limit.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _onVideoSelected(File video) async {
//     try {
//       debugPrint('Video selected: ${video.path}');
//
//       if (!await video.exists()) {
//         debugPrint('Selected video file does not exist');
//         return;
//       }
//
//       setState(() {
//         _selectedVideo = video;
//         _videoPlayerController = VideoPlayerController.file(video)
//           ..initialize().then((_) {
//             setState(() {});
//             _videoPlayerController!.play();
//           });
//       });
//
//       debugPrint('Video set with path: ${_selectedVideo?.path}');
//     } catch (e) {
//       debugPrint('Error during video selection: $e');
//     }
//   }
// }
