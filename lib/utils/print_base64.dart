import 'package:flutter/material.dart';

void printBase64(String base64String) {
  const chunkSize = 100; // Adjust chunk size as needed
  for (var i = 0; i < base64String.length; i += chunkSize) {
    final chunk = base64String.substring(i, i + chunkSize);
    debugPrint(chunk);
  }
}
