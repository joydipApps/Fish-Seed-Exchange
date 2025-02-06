import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final List<String> categoryNames;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.categoryNames,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final uniqueCategoryNames =
        categoryNames.toSet().toList(); // Remove duplicates

    // Set the default value to the first item if the selectedValue is not found
    final initialSelectedValue = uniqueCategoryNames.contains(selectedValue)
        ? selectedValue
        : (uniqueCategoryNames.isNotEmpty ? uniqueCategoryNames[0] : null);

    return DropdownButtonFormField<String>(
      value: initialSelectedValue,
      onChanged: onChanged,
      items: uniqueCategoryNames.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Select Fish Type',
        hintText: 'Choose an Option',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a Fish category';
        }
        return null; // If validation passes, return null
      },
    );
  }
}
