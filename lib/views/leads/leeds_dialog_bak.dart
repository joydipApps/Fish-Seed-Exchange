// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../models/leads/leads_add_model.dart';
// import 'leads_add_function.dart';
//
// Future<void> leedsDialogFunction({
//   required BuildContext context,
//   required WidgetRef ref,
//   required String userPhNo,
//   required String userName,
//   required String fishName,
//   required String fishQty,
// }) async {
//   final DateTime postDate = DateTime.now();
//   final String postType = 'Enquiry';
//
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       String remarks = '';
//
//       return AlertDialog(
//         title: Text('Interested'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                   'Keen to prebook fish seed for purchase.'), // Add this line here
//               SizedBox(height: 8),
//               Text(
//                 'Fish : $fishName',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Quantity'),
//                 initialValue: fishQty,
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) {
//                   fishQty = value;
//                 },
//               ),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedRateUom,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedRateUom =
//                         newValue ?? 'Kg'; // Ensure a default value is set
//                     _rateUomController.text = _selectedRateUom;
//                   });
//                 },
//                 decoration:
//                 const InputDecoration(labelText: 'Unit of Measurement'),
//                 items: ['Kg', 'Pcs']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
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
//               // Create the LeadsAddModel instance
//               LeadsAddModel leadModel = LeadsAddModel(
//                 UserPhNo: userPhNo,
//                 UserName: userName,
//                 FishName: fishName,
//                 FishQty: fishQty,
//                 FishUom: 'Kg',
//                 PostDate: postDate,
//                 PostType: postType,
//                 RefId: '', // Assuming refId is not available at this point
//                 Remarks: remarks,
//               );
//
//               // Call the addLeads function with the LeadsAddModel instance
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
