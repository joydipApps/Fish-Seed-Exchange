import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> shareImage(GlobalKey globalKey) async {
  try {
    debugPrint('shareImage: Starting shareImage function');

    final context = globalKey.currentContext;
    if (context == null) {
      debugPrint('shareImage: Error - GlobalKey context is null');
      return;
    }

    RenderRepaintBoundary boundary =
        context.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    debugPrint('shareImage: Captured image from boundary');

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      debugPrint('shareImage: Error - ByteData is null');
      return;
    }
    Uint8List pngBytes = byteData.buffer.asUint8List();
    debugPrint('shareImage: Converted image to byte data');

    // Get the temporary directory to save the file
    final directory = await getTemporaryDirectory();
    debugPrint('shareImage: Temporary directory obtained: ${directory.path}');

    final imagePath = '${directory.path}/share_card.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(pngBytes);
    debugPrint('shareImage: Image saved to temporary file: $imagePath');

    // Share the image file
    final result = await Share.shareXFiles(
      [XFile(imagePath)],
      text: 'Check out this great post in Fish Seeds app!',
    );
    debugPrint('shareImage: Image shared');

    if (result.status == ShareResultStatus.success) {
      debugPrint('shareImage: Thank you for sharing the picture!');
    }
  } catch (e) {
    debugPrint('shareImage: Error in shareImage: ${e.toString()}');
  }
}
