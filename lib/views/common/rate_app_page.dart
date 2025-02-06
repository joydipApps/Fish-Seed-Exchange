import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class RateAppPage extends StatelessWidget {
  const RateAppPage({super.key});

  Future<void> _rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      // You can handle the case where in-app review is not available
      // For example, by showing a message to the user
      debugPrint('In-app review is not available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _rateApp,
      icon: const Icon(Icons.star, color: Colors.yellow),
      label: const Text('Rate Us'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue, // Text color
      ),
    );
  }
}
