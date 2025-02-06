// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../models/enquiry/enquiry_view_model.dart';
// import '../../providers/enquiry/enquiry_view_provider.dart';
// import '../../providers/local_storage/phone_number_provider.dart';
// import '../../widgets/share_image.dart';
// import '../appbar/common_app_bar.dart';
// import '../leads/leads_dialog_page.dart';
//
// class EnquiryViewPage extends ConsumerStatefulWidget {
//   @override
//   _EnquiryViewPageState createState() => _EnquiryViewPageState();
// }
//
// class _EnquiryViewPageState extends ConsumerState<EnquiryViewPage> {
//   late String _phoneNo1;
//   final List<GlobalKey> _globalKeys = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _phoneNo1 = ref.read(phoneNoProvider);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<EnquiryViewModel> enquiryList =
//     ref.read(enquiryViewModelProvider);
//
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'Fish Seed Enquiry',
//         isIconBack: true,
//       ),
//       body: ListView.builder(
//         itemCount: enquiryList.length,
//         itemBuilder: (context, index) {
//           final enquiryData = enquiryList[index];
//
//           // Get username from the enquiry data
//           final String _phoneNo2 = enquiryData.userPhNo;
//           // Check if the phone numbers match
//           final bool _isOwnPhone = _phoneNo1 == _phoneNo2;
//
//           final key = GlobalKey();
//           _globalKeys.add(key);
//
//           return Card(
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '# ${enquiryData.enquiryId} : ${enquiryData.userName} - ${enquiryData.userPhNo}',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text('Fish : ${enquiryData.FishName}'),
//                   Text('Quantity: ${enquiryData.fishQty}'),
//                   Text('Size: ${enquiryData.fishSize}'),
//                   Text(
//                     'Posted On: ${DateFormat.yMMMd().format(enquiryData.createdDate)}',
//                   ),
//                   Text(
//                     'Required By: ${DateFormat.yMMMd().format(enquiryData.requiredDate)}',
//                   ),
//                   Text('Remarks: ${enquiryData.remarks}'),
//                   const SizedBox(width: 8),
//                   Row(
//                     children: [
//                       Text('${enquiryData.userType}'),
//                       const Spacer(),
//                       // const SizedBox(width: 8),
//                       IconButton(
//                         onPressed: _isOwnPhone
//                             ? null
//                             : () {
//                           // Navigate to LeadsDialogPage
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LeadsDialogPage(
//                                 userPhNo: enquiryData.userPhNo,
//                                 userName: enquiryData.userName,
//                                 postType: 'Enquiry',
//                                 refId: enquiryData.enquiryId,
//                                 fishName: enquiryData.FishName,
//                                 fishQty: enquiryData.fishQty,
//                               ),
//                             ),
//                           );
//                         },
//                         icon: FaIcon(
//                           FontAwesomeIcons.fishFins,
//                           color:
//                           _isOwnPhone ? Colors.grey : Colors.teal.shade500,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       IconButton(
//                         onPressed: () => shareImage(key),
//                         icon: Icon(Icons.share, color: Colors.teal.shade500),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
