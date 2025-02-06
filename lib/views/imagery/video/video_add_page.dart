import 'dart:io';
import '../../../models/imagery/video/video_file_add_model.dart';
import '../../../providers/imagery/media/video_count_provider.dart';
import '../../../utils/show_snack_dialog.dart';
import '../../../views/imagery/video/video_add_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;
import '../../appbar/common_app_bar.dart';
import 'package:newfish/utils/constants.dart';

class VideoAddPage extends ConsumerStatefulWidget {
  final String saleId;
  final String phoneNumber;
  final int seedVideoCount;

  const VideoAddPage({
    super.key,
    required this.saleId,
    required this.phoneNumber,
    required this.seedVideoCount,
  });

  @override
  VideoAddPageState createState() => VideoAddPageState();
}

class VideoAddPageState extends ConsumerState<VideoAddPage> {
  File? _selectedVideo;
  // String? _selectedVideoName;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoReady = false;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _exitIfMaxVideoLimit(int videoCount, int kMaxVideo) {
    if (videoCount == kMaxVideo) {
      if (context.mounted) {
        showSnackDialog(context, 9, "The maximum limit of $kMaxVideo reached.");
        Navigator.pop(context); // Pop the current screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('VideoAddPage Building UI');
    debugPrint('VideoAddPage _selectedVideo: $_selectedVideo');
    final videoCount = ref.watch(saleVideoCounterProvider(widget.saleId));

    return Scaffold(
      appBar: commonAppBar(
        context,
        'Add Video',
        isIconBack: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '#: ${widget.saleId}, Count: $videoCount/$kMaxVideo, Size Max $kMaxVideoSizeMB MB'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final File? video = await _pickVideoFromGallery(context);
                    if (video != null) {
                      await _onVideoSelected(video);
                    }
                  },
                  child: const Text('Select Video from Gallery'),
                ),
              ],
            ),
          ),
          if (_selectedVideo != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: _videoPlayerController != null &&
                          _videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
            ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isVideoReady
                    ? () async {
                        debugPrint('VideoAddPage Save button pressed');
                        try {
                          if (_selectedVideo == null) {
                            debugPrint('VideoAddPage No video selected');
                            return;
                          }

                          final addVideo = VideoFileAddModel(
                            saleId: widget.saleId,
                            videoId: '',
                            userPhNo: widget.phoneNumber,
                            videoFile: _selectedVideo!,
                          );

                          await videoFileAddFunction(
                            context: context,
                            ref: ref,
                            addVideo: addVideo,
                          );
                          _exitIfMaxVideoLimit(videoCount, kMaxVideo);

                          setState(() {
                            _selectedVideo = null;
                            _videoPlayerController?.dispose();
                            _videoPlayerController = null;
                            _isVideoReady = false; // Reset video readiness
                          });
                        } catch (e) {
                          debugPrint('VideoAddPage Error saving video: $e');
                        }
                      }
                    : null, // Disable button if video is not ready
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<File?> _pickVideoFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile != null) {
      final File videoFile = File(pickedFile.path);
      debugPrint('Video selected: ${videoFile.path}');

      const fileSizeLimit = kMaxVideoSizeMB * 1024 * 1024; // 10 MB in bytes

      if (videoFile.lengthSync() <= fileSizeLimit) {
        // Generate the video name
        final now = DateTime.now();
        final formattedDateTime =
            '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
        final extension = path.extension(videoFile.path);
        // _selectedVideoName =
        //     '${widget.phoneNumber}_$formattedDateTime$extension';
        return videoFile;
      } else {
        if (context.mounted) {
          showSnackDialog(
              context, 9, "The Video file exceeds $kMaxVideoSizeMB MB Limit");
        }
        // _showFileSizeExceededDialog(context);

        return null;
      }
    } else {
      if (context.mounted) {
        showSnackDialog(context, 9, "No Video Selected");
      }
      return null;
    }
  }

  // void _showFileSizeExceededDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('File Size Exceeded'),
  //         content: const Text(
  //             'The selected video file exceeds the 10 MB size limit.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _onVideoSelected(File video) async {
    try {
      debugPrint('Video selected: ${video.path}');

      if (!await video.exists()) {
        if (context.mounted) {
          showSnackDialog(context, 9, "Selected video file does not exist");
        }
        return;
      }

      setState(() {
        _isVideoReady = false; // Disable Save button until video is ready
        _selectedVideo = video;
        _videoPlayerController = VideoPlayerController.file(video)
          ..initialize().then((_) {
            setState(() {
              _isVideoReady = true; // Enable Save button when video is ready
            });
            _videoPlayerController!.play();
          });
      });

      debugPrint('Video set with path: ${_selectedVideo?.path}');
    } catch (e) {
      debugPrint('Error during video selection: $e');
    }
  }
}
