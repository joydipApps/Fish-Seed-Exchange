// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../models/leads/leads_add_model.dart';
// import '../../providers/fish-list/fish_list_provider.dart';
// import 'leads_add_function.dart';
//
// class LeadsDialogPage extends ConsumerStatefulWidget {
//   final String userPhNo;
//   final String userName;
//   final String postType;
//   final String refId;
//   final String fishName;
//   late final int fishQty;
//
//   LeadsDialogPage({
//     Key? key,
//     required this.userPhNo,
//     required this.userName,
//     required this.postType,
//     required this.refId,
//     required this.fishName,
//     required this.fishQty,
//   }) : super(key: key);
//
//   @override
//   _LeadsDialogPageState createState() => _LeadsDialogPageState();
// }
//
// class _LeadsDialogPageState extends ConsumerState<LeadsDialogPage> {
//   late String _selectedUom;
//   late String _selectedFish;
//   late String _remarks;
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedUom = 'Kg'; // Initialize default value for UOM
//     _selectedFish = ''; // Initialize selected fish as empty
//     _remarks = ''; // Initialize remarks as empty
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final fishList = ref.watch(fishListModelProvider);
//     final fishNames = fishList.map((fish) => fish.fishName).toList();
//
//     return AlertDialog(
//       title: Text('Interested:'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Text('Keen to prebook fish seed for purchase.'),
//               SizedBox(height: 8),
//               DropdownButtonFormField<String>(
//                 value: _selectedFish.isNotEmpty ? _selectedFish : null,
//                 hint: Text('Select a fish'),
//                 decoration: InputDecoration(
//                   labelText: 'Fish',
//                 ),
//                 validator: (value) {
//                   if (_selectedFish.isEmpty) {
//                     return 'Please select a fish';
//                   }
//                   return null;
//                 },
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedFish = newValue ?? '';
//                   });
//                 },
//                 items: fishNames.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(labelText: 'Quantity'),
//                       initialValue: widget.fishQty.toString(),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a quantity';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return 'Please enter a valid number';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           widget.fishQty =
//                               int.tryParse(value) ?? widget.fishQty;
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedUom,
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedUom = newValue ?? 'Kg';
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Unit of Measurement',
//                       ),
//                       items: ['Kg', 'Pcs']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 8),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Remarks'),
//                 initialValue: _remarks,
//                 onChanged: (value) {
//                   setState(() {
//                     _remarks = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         SizedBox(width: 8),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             if (_formKey.currentState?.validate() == true) {
//               LeadsAddModel leadModel = LeadsAddModel(
//                 userPhNo: widget.userPhNo,
//                 userName: widget.userName,
//                 fishName: _selectedFish,
//                 fishQty: widget.fishQty,
//                 qtyUom: _selectedUom,
//                 postDate: DateTime.now(),
//                 postType: widget.postType,
//                 refId: widget.refId,
//                 remarks: _remarks,
//               );
//
//               leadsAddFunction(context, ref, leadModel);
//               Navigator.of(context).pop();
//             }
//           },
//           child: Text(
//             'Confirm',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
