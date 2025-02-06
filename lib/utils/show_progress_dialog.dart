import 'package:flutter/material.dart';

void showProgressDialogSync(BuildContext context) {
  showProgressDialog(context); // Call the async function without awaiting
}

Future<void> showProgressDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierColor: Colors.transparent, // Make the barrier color transparent
    barrierDismissible: false,
    builder: (context) => const Stack(
      children: [
        Center(
          child: CircularProgressIndicator(
            value: null,
            backgroundColor: Colors.transparent,
            strokeWidth: 5.0,
            strokeCap: StrokeCap.round,
            color: Colors.cyanAccent,
          ),
        ),
      ],
    ),
  );
}
