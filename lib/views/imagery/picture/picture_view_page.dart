import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/imagery/picture/picture_view_model.dart';
import '../../../providers/imagery/picture/picture_view_provider.dart';
import '../../appbar/common_app_bar.dart';

class PictureViewPage extends ConsumerWidget {
  final String saleId;
  const PictureViewPage({
    super.key,
    required this.saleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<PictureViewModel> pictures = ref.watch(pictureViewModelProvider);
    final List<PictureViewModel> pictures = ref
        .watch(pictureViewModelProvider)
        .where((picture) => picture.saleId == saleId)
        .toList();
    // Debug print the number of pictures
    debugPrint('Number of pictures for saleId $saleId: ${pictures.length}');
    debugPrint('Number of pictures for saleId $saleId: ${pictures.length}');

    // Add these variables for image sizing
    final double screenWidth = MediaQuery.of(context).size.width;
    const double aspectRatio = 16 / 9; // 16:9 aspect ratio
    final double imageHeight = screenWidth / aspectRatio;

    return Scaffold(
      appBar: commonAppBar(
        context,
        'View Pictures',
        isIconBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: pictures.asMap().entries.map((entry) {
            final PictureViewModel picture = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  // Show a dialog with the larger image when tapped
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                        width: screenWidth, // Adjust as needed
                        height:
                            screenWidth / aspectRatio, // Maintain aspect ratio
                        child: Center(
                          child: InteractiveViewer(
                            boundaryMargin: const EdgeInsets.all(
                                8.0), // Add margin around the image
                            minScale: 0.5, // Set the minimum scale
                            maxScale: 4.0, // Set the maximum scale
                            child: Image.memory(
                              base64Decode(picture.pictureBase64),
                              width: screenWidth,
                              height: imageHeight,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0), // Add padding
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.teal.shade200), // Add border
                    borderRadius:
                        BorderRadius.circular(16.0), // Add border radius
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0), // Adjust border radius
                    child: FittedBox(
                      child: Image.memory(
                        base64Decode(picture.pictureBase64),
                        width: screenWidth,
                        height: imageHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
