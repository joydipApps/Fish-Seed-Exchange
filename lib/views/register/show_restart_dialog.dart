import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

Future<void> showRestartDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Restart App',
        ),
        content: const Text(
          'Your changes have been saved. Do you want to restart the app to apply the changes?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Restart the app
              await Restart.restartApp();
            },
            child: const Text(
              'Save & Restart',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
