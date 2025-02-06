import 'package:flutter/material.dart';

class FishDropdown extends StatelessWidget {
  final List<String> fishNames;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const FishDropdown({
    super.key,
    required this.fishNames,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String? defaultValue = fishNames.isNotEmpty ? fishNames.first : null;

    if (selectedValue != null && fishNames.contains(selectedValue)) {
      defaultValue = selectedValue;
    }

    return DropdownButtonFormField<String>(
      value: defaultValue,
      onChanged: onChanged,
      items: fishNames.map((fishName) {
        return DropdownMenuItem<String>(
          value: fishName,
          child: Text(fishName),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Select Fish Name',
        hintText: 'Choose an Option',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a Fish Name';
        }
        return null; // If validation passes, return null
      },
    );
  }
}
