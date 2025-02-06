import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter-sort/sort_on_distance_provider.dart';

class SortOnDistancePage extends ConsumerStatefulWidget {
  const SortOnDistancePage({
    super.key,
  });

  @override
  _SortOnDistancePageState createState() => _SortOnDistancePageState();
}

class _SortOnDistancePageState extends ConsumerState<SortOnDistancePage> {
  @override
  @override
  Widget build(BuildContext context) {
    final bool isFilterOn = ref.watch(sortOnDistanceProvider);
    final contentTextStyle = Theme.of(context).dialogTheme.contentTextStyle;

    return AlertDialog(
      title: const Text('Sort on Distance:'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              debugPrint('Reset button pressed.');
              ref.read(sortOnDistanceProvider.notifier).state = false;
              Navigator.of(context).pop();
            },
            child: Text(
              'Close-Reset',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isFilterOn
                    ? Colors.purple.shade400
                    : contentTextStyle?.color,
              ),
            )),
        TextButton(
          onPressed: () {
            ref.read(sortOnDistanceProvider.notifier).state = true;

            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
