import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/show_progress_dialog.dart';
import '../utils/show_snack_dialog.dart';

Future<void> launchGoogleMaps({
  required BuildContext context,
  required double latitude,
  required double longitude,
}) async {
  // Try launching with the geo: scheme
  final Uri geoUrl =
      Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude');
  // Default URL to launch in the browser
  final Uri defaultUrl =
      Uri.parse('https://maps.google.com/?q=$latitude,$longitude');

  showProgressDialogSync(context); // Show loading indicator

  try {
    if (await canLaunchUrl(geoUrl)) {
      await launchUrl(geoUrl);
    } else {
      // If geo: scheme doesn't work, try launching in the default browser
      if (await canLaunchUrl(defaultUrl)) {
        await launchUrl(defaultUrl);
      } else {
        // If neither works, show an error message
        var msg = 'Could not launch maps';
        if (context.mounted) {
          showSnackDialog(context, 2, msg);
        }
      }
    }
  } catch (e) {
    if (context.mounted) {
      showSnackDialog(context, 2, 'Error: $e');
    }
  } finally {
    // Dismiss the loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
