import 'dart:io';

import 'package:file_picker/file_picker.dart';
import '../../utils/show_snack_dialog.dart';
import 'package:flutter/material.dart';

Future<File?> pickVideoFile(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.video,
    allowedExtensions: [
      'mp4',
      'mov',
      '3gp',
      'avi',
      'flv',
      'mkv',
      'webm',
    ], // Specify allowed video extensions
  );
  if (result != null) {
    final file = File(result.files.single.path!);
    const fileSizeLimit = 5 * 1024 * 1024; // 5 MB in bytes

    if (file.lengthSync() <= fileSizeLimit) {
      return file;
    } else {
      showSnackDialog(
        context,
        7,
        'Video file size exceeds limit (5 MB)',
      );
    }
  }
  return null;
}
