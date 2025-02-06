// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/enquiry/enquiry_add_model.dart';
// import '../../providers/enquiry/enquiry_add_provider.dart'; // Import necessary providers
// import '../../service/validation_function.dart';
// import '../../utils/show_snack_dialog.dart';
// import '../../utils/local_shared_Storage.dart';
// import '../../widgets/common_app_bar.dart';
//
// class EnquiryAddPage extends ConsumerStatefulWidget {
//   const EnquiryAddPage({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<EnquiryAddPage> createState() => _EnquiryAddPageState();
// }
//
// class _EnquiryAddPageState extends ConsumerState<EnquiryAddPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _fishNameController = TextEditingController();
//   final TextEditingController _fishQtyController = TextEditingController();
//   final TextEditingController _fishSizeController = TextEditingController();
//   final TextEditingController _remarksController = TextEditingController();
//   late DateTime _requiredDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _requiredDate = DateTime.now();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBar(context, 'Add Enquiry', isIconBack: true),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: _fishNameController,
//                   validator: (value) =>
//                       TextFieldValidation.validateGeneralText(value),
//                   textCapitalization: TextCapitalization.words,
//                   decoration: const InputDecoration(
//                     labelText: 'Fish Name',
//                     hintText: 'Enter fish name',
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _fishQtyController,
//                   validator: (value) =>
//                       TextFieldValidation.validateGeneralText(value),
//                   decoration: const InputDecoration(
//                     labelText: 'Fish Quantity',
//                     hintText: 'Enter fish quantity',
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _fishSizeController,
//                   validator: (value) =>
//                       TextFieldValidation.validateGeneralText(value),
//                   decoration: const InputDecoration(
//                     labelText: 'Fish Size',
//                     hintText: 'Enter fish size',
//                   ),
//                 ),
//                 TextFormField(
//                   controller: _remarksController,
//                   validator: (value) =>
//                       TextFieldValidation.validateGeneralText(value),
//                   decoration: const InputDecoration(
//                     labelText: 'Remarks',
//                     hintText: 'Enter remarks',
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState?.validate() ?? false) {
//                       // Form is valid, proceed with submission
//                       final EnquiryAddModel enquiryData = EnquiryAddModel(
//                         UserPhNo: '', // Populate with user's phone number
//                         FishName: _fishNameController.text,
//                         FishQty: int.parse(_fishQtyController.text),
//                         FishSize: _fishSizeController.text,
//                         RequiredDate: _requiredDate,
//                         Remarks: _remarksController.text,
//                         CreatedDate: DateTime.now(),
//                       );
//
//                       final enquiryAddService =
//                       ref.read(enquiryAddServiceProvider);
//
//                       final apiResponse =
//                       await enquiryAddService.enquiryAddData(enquiryData);
//
//                       if (apiResponse != null) {
//                         // Handle success
//                         displaySnackBar(
//                             context, 1, 'Enquiry added successfully');
//                         // Clear text fields
//                         _fishNameController.clear();
//                         _fishQtyController.clear();
//                         _fishSizeController.clear();
//                         _remarksController.clear();
//                         setState(() {
//                           _requiredDate = DateTime.now();
//                         });
//                       } else {
//                         // Handle failure
//                         displaySnackBar(context, 2, 'Failed to add enquiry');
//                       }
//                     }
//                   },
//                   child: const Text('Add Enquiry'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
