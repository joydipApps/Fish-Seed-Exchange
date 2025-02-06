import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/show_progress_dialog.dart';
import '../utils/show_snack_dialog.dart';

Future<void> launchPhoneDialer({
  required BuildContext context,
  required String phNo,
}) async {
  final phoneNumber = phNo.startsWith('+91') ? phNo : '+91$phNo';
  final url = Uri.parse('tel:$phoneNumber');

  showProgressDialogSync(context); // Show loading indicator

  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      var msg = 'Could not launch Phone Dialer with $phoneNumber';
      showSnackDialog(context, 2, msg);
    }
  } finally {
    // Dismiss the loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
