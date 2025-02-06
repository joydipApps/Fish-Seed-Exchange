import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter-sort/group_name_filter_provider.dart';
import '../../providers/filter-sort/selected_group_name_provider.dart';
import '../fish-list/fish_drop_down.dart';

class GroupNameFilterPage extends ConsumerStatefulWidget {
  const GroupNameFilterPage({
    super.key,
  });

  @override
  _GroupNameFilterPageState createState() => _GroupNameFilterPageState();
}

class _GroupNameFilterPageState extends ConsumerState<GroupNameFilterPage> {
  String _selectedGroup = 'Buyer';

  @override
  void initState() {
    super.initState();
    _selectedGroup; // Initialize selected group as empty
    debugPrint('GroupNameFilterPage: Initialized with empty selected group.');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueGroupNames = ref.watch(groupNameFilterProvider);
    final bool isFilterOn = ref.watch(toggleGroupNameProvider);
    final contentTextStyle = Theme.of(context).dialogTheme.contentTextStyle;

    return AlertDialog(
      title: const Text('Filter Trade Group:'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Text('Keen to filter group names.'),
            const SizedBox(height: 8),
            FishDropdown(
              fishNames: uniqueGroupNames,
              selectedValue: _selectedGroup,
              onChanged: (String? newValue) {
                debugPrint('GroupDropdown: Value changed to $newValue');
                setState(() {
                  _selectedGroup = newValue ?? '';
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
            final notifier = ref.read(selectedGroupNameProvider.notifier);
            notifier.reset();
            ref.read(toggleGroupNameProvider.notifier).state = false;
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
                'Confirm button pressed with selected group: $_selectedGroup');
            final notifier = ref.read(selectedGroupNameProvider.notifier);
            notifier.setSelectedGroupName(_selectedGroup);
            ref.read(toggleGroupNameProvider.notifier).state = true;
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
