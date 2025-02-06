import '../../providers/filter-sort/sort_newest_first_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortNewestFirstPage extends ConsumerStatefulWidget {
  const SortNewestFirstPage({
    super.key,
  });

  @override
  _SortNewestFirstPageState createState() => _SortNewestFirstPageState();
}

class _SortNewestFirstPageState extends ConsumerState<SortNewestFirstPage> {
  @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final bool isFilterOn = ref.watch(sortNewestFirstProvider);
    final contentTextStyle = Theme.of(context).dialogTheme.contentTextStyle;

    return AlertDialog(
      title: const Text('Sort Newest First:'),
      // content: SingleChildScrollView(
      //     // child: Column(
      //     //   mainAxisAlignment: MainAxisAlignment.start,
      //     //   children: <Widget>[
      //     //     // Text('Keen to filter group names.'),
      //     //     SizedBox(height: 8),
      //     //     FishDropdown(
      //     //       fishNames: uniqueGroupNames,
      //     //       selectedValue: _selectedGroup,
      //     //       onChanged: (String? newValue) {
      //     //         debugPrint('GroupDropdown: Value changed to $newValue');
      //     //         setState(() {
      //     //           _selectedGroup = newValue ?? '';
      //     //         });
      //     //       },
      //     //     ),
      //     //     SizedBox(height: 8),
      //     //   ],
      //     // ),
      //     ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ref.read(sortNewestFirstProvider.notifier).state = false;
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
            ref.read(sortNewestFirstProvider.notifier).state = true;
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
