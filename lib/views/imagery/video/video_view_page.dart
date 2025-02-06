// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../models/imagery/video_streaming/video_file_view_model.dart';
// import '../../../providers/imagery/video_streaming/video_file_view_provider.dart';
// import '../../appbar/common_app_bar.dart';
//
// class VideoViewPage extends ConsumerStatefulWidget {
//   const VideoViewPage({super.key});
//
//   @override
//   VideoViewPageState createState() => VideoViewPageState();
// }
//
// class VideoViewPageState extends ConsumerState<VideoViewPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final List<VideoFileViewModel> videos =
//         ref.watch(videoFileViewModelProvider);
//     final mediaQuery = MediaQuery.of(context);
//     final double containerHeight =
//         mediaQuery.size.height * 0.5; // Adjust height as needed
//     final double containerWidth =
//         mediaQuery.size.width * 0.9; // Adjust width as needed
//
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'View Videos',
//         isIconBack: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               margin:
//                   const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//               width: containerWidth,
//               height: containerHeight,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.0),
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1.0,
//                 ),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 8.0,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: videos.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: _VideoItem(video: videos[index]),
//                   );
//                 },
//                 onPageChanged: (int page) {
//                   setState(() {
//                     _currentPage = page;
//                   });
//                 },
//               ),
//             ),
//           ),
//           // Add indicators
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               videos.length,
//               buildPageIndicator,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPageIndicator(int index) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
//       height: 8.0,
//       width: 8.0,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: _currentPage == index
//             ? Colors.amberAccent
//             : Colors.amberAccent.withOpacity(0.5),
//       ),
//     );
//   }
// }
//
// class _VideoItem extends StatefulWidget {
//   final VideoFileViewModel video;
//
//   const _VideoItem({required this.video});
//
//   @override
//   _VideoItemState createState() => _VideoItemState();
// }
//
// class _VideoItemState extends State<_VideoItem> {
//   late VideoPlayerController _controller;
//   bool _isVideoInitialized = false;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideo();
//   }
//
//   Future<void> _initializeVideo() async {
//     try {
//       final videoData = base64Decode(widget.video.videoBase64);
//       final file = await _writeVideoToFile(videoData);
//       _controller = VideoPlayerController.file(file);
//       await _controller.initialize(); // Initialize the video player
//
//       _controller.addListener(() {
//         if (_controller.value.hasError) {
//           setState(() {
//             _errorMessage = _controller.value.errorDescription;
//           });
//         }
//         // Update state to refresh progress bar
//         if (mounted) {
//           setState(() {});
//         }
//       });
//
//       setState(() {
//         _isVideoInitialized = true;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to initialize video: $e';
//       });
//     }
//   }
//
//   Future<File> _writeVideoToFile(Uint8List data) async {
//     final appDir = await getApplicationDocumentsDirectory();
//     final file = File('${appDir.path}/${widget.video.videoId}.mp4');
//     await file.writeAsBytes(data);
//     return file;
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isVideoInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (_errorMessage != null) {
//       return Text('Error: $_errorMessage');
//     }
//
//     return GestureDetector(
//       onTap: () {
//         if (_controller.value.isPlaying) {
//           _controller.pause();
//         } else {
//           _controller.play();
//         }
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ),
//           if (!_controller.value.isPlaying)
//             const Icon(
//               Icons.play_circle_fill,
//               size: 64.0,
//               color: Colors.white,
//             ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: VideoProgressIndicator(
//               _controller,
//               allowScrubbing: true,
//               colors: VideoProgressColors(
//                 playedColor: Colors.amberAccent,
//                 bufferedColor: Colors.amberAccent.withOpacity(0.5),
//                 backgroundColor: Colors.black26,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
