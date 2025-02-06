import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/imagery/video/video_list_view_model.dart';
import '../../../providers/imagery/video/video_list_view_provider.dart';
import '../../appbar/common_app_bar.dart';
import 'video_player_page.dart';

class VideoListPage extends ConsumerStatefulWidget {
  final String saleId;
  const VideoListPage({
    super.key,
    required this.saleId,
  });

  @override
  VideoListPageState createState() => VideoListPageState();
}

class VideoListPageState extends ConsumerState<VideoListPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Building VideoListPage');
    // final videoList = ref.read(videoListViewModelProvider);
    final List<VideoListViewModel> videoList = ref
        .watch(videoListViewModelProvider)
        .where((video) => video.saleId == widget.saleId)
        .toList();

    return Scaffold(
      appBar: commonAppBar(context, 'Video List', isIconBack: true),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final video = videoList[index];
          final imageBytes = base64Decode(video.pictureBase64);

          debugPrint(
              'Rendering video item at index $index with Video ID: ${video.videoId}');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.memory(imageBytes),
                      IconButton(
                        icon: Icon(Icons.play_circle_fill,
                            size: 64, color: Colors.white.withOpacity(0.7)),
                        onPressed: () {
                          debugPrint(
                              'Play button pressed for video URL: ${video.videoUrl}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayerPage(videoUrl: video.videoUrl),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Text('Sale ID: ${video.saleId}'),
                  // Text('Video ID: ${video.videoId}'),
                  // Text('User Phone: ${video.userPhNo}'),
                  // Text('Video Path: ${video.videoUrl}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
