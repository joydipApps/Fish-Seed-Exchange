import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HelperVideoScreen extends StatefulWidget {
  const HelperVideoScreen({super.key});

  @override
  HelperVideoScreenState createState() => HelperVideoScreenState();
}

class HelperVideoScreenState extends State<HelperVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Use network or local asset video
    _controller = VideoPlayerController.networkUrl(
        'https://your_video_url_here.mp4' as Uri)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helper Video'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
