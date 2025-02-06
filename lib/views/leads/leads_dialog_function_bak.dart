// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../models/fish-list/fish_list_model.dart';
// import '../../models/leads/leads_add_model.dart';
// import '../../providers/fish-list/fish_list_provider.dart';
// import '../fish-list/fish_drop_down.dart';
// import 'leads_add_function.dart';
//
// Future<void> leedsDialogFunction({
//   required BuildContext context,
//   required WidgetRef ref,
//   required String userPhNo,
//   required String userName,
//   required String postType,
//   required String refId,
//   required String fishName,
//   required int fishQty,
// }) async {
//   final DateTime postDate = DateTime.now();
//   // final String postType = 'Enquiry';
//
//   String _selectedUom = 'Kg'; // Declare _selectedUom
//
//   final List<FishListModel> fishList = ref.watch(fishListModelProvider);
//   final List<String> fishNames =
//   fishList.map((fish) => fish.fishName ?? '').toList();
//   String _selectedFish = ''; // Track selected fish name
//
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       String remarks = '';
//
//       return AlertDialog(
//         title: Text('Interested :'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'Keen to prebook fish seed for purchase.',
//               ),
//               SizedBox(height: 8),
//               FishDropdown(
//                 fishNames: fishNames,
//                 selectedValue: _selectedFish,
//                 onChanged: (newValue) {
//                   _selectedFish = newValue ?? '';
//                 },
//               ),
//               // Text(
//               //   'Fish : $fishName',
//               //   style: TextStyle(fontWeight: FontWeight.bold),
//               // ),
//               SizedBox(height: 8),
//               Row(
//                 // Use Row to place TextFormField and DropdownButtonFormField in one row
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(labelText: 'Quantity'),
//                       initialValue: fishQty.toString(),
//                       keyboardType: TextInputType.number,
//                       onChanged: (value) {
//                         fishQty = value as int;
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 8), // Add some spacing between the fields
//                   Expanded(
//                     child: Consumer(
//                       builder: (context, watch, _) {
//                         final _uomController =
//                         TextEditingController(text: _selectedUom);
//                         return DropdownButtonFormField<String>(
//                           value: _selectedUom,
//                           onChanged: (String? newValue) {
//                             _selectedUom =
//                                 newValue ?? 'Kg'; // Update _selectedUom
//                             _uomController.text =
//                                 _selectedUom; // Update _uomController.text
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Unit of Measurement',
//                           ),
//                           items: ['Kg', 'Pcs']
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Remarks'),
//                 onChanged: (value) {
//                   remarks = value;
//                 },
//               ),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               LeadsAddModel leadModel = LeadsAddModel(
//                 UserPhNo: userPhNo,
//                 UserName: userName,
//                 FishName: fishName,
//                 FishQty: fishQty,
//                 FishUom: _selectedUom, // Use _selectedUom here
//                 PostDate: postDate,
//                 PostType: postType,
//                 RefId: refId,
//                 Remarks: remarks,
//               );
//
//               leadsAddFunction(context, ref, leadModel);
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text(
//               'Confirm',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
