import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter-sort/district_name_filter_provider.dart';
import '../../providers/filter-sort/selected_district_name_provider.dart';
import '../fish-list/fish_drop_down.dart';

class DistrictNameFilterPage extends ConsumerStatefulWidget {
  const DistrictNameFilterPage({
    super.key,
  });

  @override
  DistrictNameFilterPageState createState() => DistrictNameFilterPageState();
}

class DistrictNameFilterPageState
    extends ConsumerState<DistrictNameFilterPage> {
  String _selectedDistrict = 'Kolkata';

  @override
  void initState() {
    super.initState();
    final List<String> uniqueDistrictNames =
        ref.read(districtNameFilterProvider);
    if (uniqueDistrictNames.isNotEmpty) {
      _selectedDistrict = uniqueDistrictNames[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueDistrictNames =
        ref.watch(districtNameFilterProvider);
    final bool isFilterOn = ref.watch(toggleDistrictNameProvider);
    final contentTextStyle = Theme.of(context).dialogTheme.contentTextStyle;

    return AlertDialog(
      title: const Text('Filter District:'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Text('Keen to filter district names.'),
            const SizedBox(height: 8),
            FishDropdown(
              fishNames: uniqueDistrictNames,
              selectedValue: _selectedDistrict,
              onChanged: (String? newValue) {
                debugPrint('DistrictDropdown: Value changed to $newValue');
                setState(() {
                  _selectedDistrict = newValue ?? '';
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
            final notifier = ref.read(selectedDistrictNameProvider.notifier);
            notifier.reset();
            ref.read(toggleDistrictNameProvider.notifier).state = false;
            Navigator.of(context).pop();
          },
          child: Text(
            'Close-Reset',
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
                'Confirm button pressed with selected district: $_selectedDistrict');
            final notifier = ref.read(selectedDistrictNameProvider.notifier);
            notifier.setSelectedDistrictName(_selectedDistrict);
            ref.read(toggleDistrictNameProvider.notifier).state = true;
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
