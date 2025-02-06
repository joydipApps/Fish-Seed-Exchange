// import 'package:flutter/material.dart';
//
// class FishDropdown extends StatelessWidget {
//   final List<String> fishNames;
//   final String? selectedValue;
//   final ValueChanged<String?> onChanged;
//
//   FishDropdown({
//     required this.fishNames,
//     this.selectedValue,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     String? defaultValue = fishNames.isNotEmpty ? fishNames.first : null;
//
//     if (selectedValue != null && fishNames.contains(selectedValue)) {
//       defaultValue = selectedValue;
//     }
//
//     return DropdownButtonFormField<String>(
//       value: defaultValue,
//       onChanged: onChanged,
//       items: fishNames.map((fishName) {
//         return DropdownMenuItem<String>(
//           value: fishName,
//           child: Text(fishName),
//         );
//       }).toList(),
//       decoration: InputDecoration(
//         labelText: 'Select Fish',
//         hintText: 'Choose a fish',
//       ),
//     );
//   }
// }
