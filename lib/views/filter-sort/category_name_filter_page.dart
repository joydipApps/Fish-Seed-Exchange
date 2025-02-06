import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter-sort/fish_category_filter_provider.dart';
import '../../providers/filter-sort/selected_fish_category_provider.dart';
import '../fish-list/category_drop_down.dart';

class CategoryNameFilterPage extends ConsumerStatefulWidget {
  const CategoryNameFilterPage({
    super.key,
  });

  @override
  CategoryNameFilterPageState createState() => CategoryNameFilterPageState();
}

class CategoryNameFilterPageState
    extends ConsumerState<CategoryNameFilterPage> {
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory; // Initialize selected category as empty
    debugPrint(
        'CategoryNameFilterPage: Initialized with empty selected category.');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> uniqueCategoryNames =
        ref.watch(fishCategoryFilterProvider);
    final bool isFilterOn = ref.watch(toggleFishCategoryProvider);
    final contentTextStyle = Theme.of(context).dialogTheme.contentTextStyle;

    return AlertDialog(
      title: const Text('Filter Category:'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Text('Keen to filter category names.'),
            const SizedBox(height: 8),
            CategoryDropdown(
              categoryNames: uniqueCategoryNames,
              selectedValue: _selectedCategory,
              onChanged: (String? newValue) {
                debugPrint('CategoryDropdown: Value changed to $newValue');
                setState(() {
                  _selectedCategory = newValue ?? '';
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
            final notifier = ref.read(selectedCategoryNameProvider.notifier);
            notifier.reset();
            ref.read(toggleFishCategoryProvider.notifier).state = false;
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
                'Confirm button pressed with selected category: $_selectedCategory');
            final notifier = ref.read(selectedCategoryNameProvider.notifier);
            notifier.setSelectedCategoryName(_selectedCategory);
            ref.read(toggleFishCategoryProvider.notifier).state = true;
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
