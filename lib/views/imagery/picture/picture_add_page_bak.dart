// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../studio/image_input_camera.dart';
// import '../../studio/image_input_gallery.dart';
// import '../../widgets/common_app_bar.dart';
// import 'package:fishseeds_dev/views/imegery/picture_add_function.dart';
//
// class PictureAddPage extends ConsumerStatefulWidget {
//   final String saleId;
//   final String phoneNumber;
//   final int seedPicCount;
//
//   const PictureAddPage({
//     Key? key,
//     required this.saleId,
//     required this.phoneNumber,
//     required this.seedPicCount,
//   }) : super(key: key);
//
//   @override
//   _PictureAddPageState createState() => _PictureAddPageState();
// }
//
// class _PictureAddPageState extends ConsumerState<PictureAddPage> {
//   late File _selectedImage;
//   late String _selectedRadio;
//   late String base64Image;
//
//   @override
//   void initState() {
//     super.initState();
//     // Set default radio selection to 'camera'
//     _selectedRadio = 'camera';
//     debugPrint('selected camera');
//   }
//
//   void _handleRadioChange(String? value) {
//     setState(() {
//       _selectedRadio = value!;
//     });
//     debugPrint('Radio value changed: $_selectedRadio');
//   }
//
//   Future<void> _onImageSelected(File image) async {
//     List<int> imageBytes = await image.readAsBytes();
//     base64Image = base64Encode(imageBytes);
//     print('base64Image: $base64Image');
//     setState(() {
//       _selectedImage = image;
//     });
//     debugPrint('State set');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrint('Building UI');
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'Add Picture',
//         isIconBack: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Sale ID: ${widget.saleId}'),
//                 Text('Phone Number: ${widget.phoneNumber}'),
//                 Text('Total Count: ${widget.seedPicCount}'),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Radio<String>(
//                   value: 'camera',
//                   groupValue: _selectedRadio,
//                   onChanged: _handleRadioChange,
//                 ),
//                 const Text('Camera'),
//                 Radio<String>(
//                   value: 'gallery',
//                   groupValue: _selectedRadio,
//                   onChanged: _handleRadioChange,
//                 ),
//                 const Text('Gallery'),
//               ],
//             ),
//           ),
//           if (_selectedRadio == 'camera') ImageInputCamera(_onImageSelected),
//           if (_selectedRadio == 'gallery')
//             ImageInputGallery(onImageSelected: _onImageSelected),
//           if (_selectedImage != null)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                   ),
//                 ),
//                 child: Image.file(
//                   _selectedImage,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 16.0),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () =>
//                     savePicture(context, ref, widget.saleId, base64Image!),
//                 // onPressed: base64Image != null
//                 //     ? () =>
//                 //         savePicture(context, ref, widget.saleId, base64Image!)
//                 //     : null,
//                 child: Text('Save'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
