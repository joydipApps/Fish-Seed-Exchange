import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter-sort/fish_name_filter_provider.dart';
import '../../providers/filter-sort/selected_fish_name_provider.dart';
import '../fish-list/fish_drop_down.dart';

class FishNameFilterPage extends ConsumerStatefulWidget {
  const FishNameFilterPage({
    super.key,
  });

  @override
  FishNameFilterPageState createState() => FishNameFilterPageState();
}

class FishNameFilterPageState extends ConsumerState<FishNameFilterPage> {
  String _selectedFish = 'Rui';

  @override
  void initState() {
    super.initState();
    _selectedFish; // Initialize selected fish as empty
    debugPrint('FishNameFilterPage: Initialized with empty selected fish.');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueFishNames = ref.watch(fishNameFilterProvider);
    final bool isFilterOn = ref.watch(toggleFishNameProvider);
    final contentTextStyle = Theme.of(context).dialogTheme.contentTextStyle;

    return AlertDialog(
      title: const Text('Filter Fish:'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Text('Keen to filter fish names.'),
            const SizedBox(height: 8),
            FishDropdown(
              fishNames: uniqueFishNames,
              selectedValue: _selectedFish,
              onChanged: (String? newValue) {
                debugPrint('FishDropdown: Value changed to $newValue');
                setState(() {
                  _selectedFish = newValue ?? '';
                });
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            debugPrint('Reset button pressed.');
            final notifier = ref.read(selectedFishNameProvider.notifier);
            notifier.reset();
            ref.read(toggleFishNameProvider.notifier).state = false;
            Navigator.of(context).pop();
          },
          child: Text(
            'Reset',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  isFilterOn ? Colors.purple.shade400 : contentTextStyle?.color,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            debugPrint(
                'Confirm button pressed with selected fish: $_selectedFish');
            final notifier = ref.read(selectedFishNameProvider.notifier);
            notifier.setSelectedFishName(_selectedFish);
            ref.read(toggleFishNameProvider.notifier).state = true;
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
