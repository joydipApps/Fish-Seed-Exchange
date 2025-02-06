import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    debugPrint('VideoPlayerWidget initState called');
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    debugPrint('Initializing video player with URL: ${widget.videoUrl}');
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError) {
        debugPrint(
            'Video player error: ${_videoPlayerController.value.errorDescription}');
      } else {
        debugPrint('Video player state updated');
      }
    });

    try {
      await _videoPlayerController.initialize();
      debugPrint('Video player initialized successfully');
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
      );

      setState(() {
        debugPrint('Video player state set to initialized');
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    debugPrint('Disposing video player and Chewie controller');
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Building VideoPlayerWidget');
    return _isInitialized
        ? AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: Chewie(controller: _chewieController!),
          )
        : Center(child: CircularProgressIndicator());
  }
}
