// import '../../views/home/show_address_function.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../providers/local_storage/phone_number_provider.dart';
// import '../../providers/local_storage/phoneno_presence_provider.dart';
// import '../../routes/app_route_constants.dart';
// import '../../widgets/common_app_bar.dart';
// import '../../models/seed_sale/seed_sale_view_model.dart';
// import '../../providers/seed_sale_view_provider.dart';
// import '../leads/leads_dialog_function_delete.dart';
// import '../location/location_view_function.dart';
// import '../media/get_picture_function.dart';
// import '../media/get_video_function.dart';
// import 'home_drawer.dart';
// import 'home_page_bottom.dart';
//
// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({required this.isPhoneNoPresent, Key? key}) : super(key: key);
//
//   final bool isPhoneNoPresent;
//
//   @override
//   HomePageState createState() => HomePageState();
// }
//
// class HomePageState extends ConsumerState<HomePage> {
//   int _selectedIndex = 0;
//   late bool _isPhoneNoPresent;
//   late String _phoneNo1;
//
//   @override
//   void initState() {
//     super.initState();
//     _isPhoneNoPresent = widget.isPhoneNoPresent;
//     _phoneNo1 = ref.read(phoneNoProvider);
//   }
//
//   void _onItemTapped(int index) {
//     GoRouter _goRouter = GoRouter.of(context);
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     // Navigate to the corresponding route based on the index
//     if (_isPhoneNoPresent) {
//       // Handle navigation when phone number is present
//       switch (index) {
//         case 0:
//           _goRouter.pushNamed(AppRouteConstants.homePageRouteName);
//           break;
//         case 1:
//           _goRouter.pushNamed(AppRouteConstants.viewEnquiryPageRouteName);
//           break;
//         case 2:
//           _goRouter.pushNamed(AppRouteConstants.viewLeadsPageRouteName);
//           break;
//         case 3:
//         // _goRouter.pushNamed(AppRouteConstants.addSeedSalePageRouteName);
//           break;
//       }
//     } else {
//       // Handle navigation when phone number is not present
//       switch (index) {
//         case 0:
//           _goRouter.pushNamed(AppRouteConstants.homePageRouteName);
//           break;
//         case 1:
//           _goRouter.pushNamed(AppRouteConstants.viewEnquiryPageRouteName);
//           break;
//         case 2:
//           _goRouter.pushNamed(AppRouteConstants.registerUserRouteName);
//           break;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _isPhoneNoPresent = ref.watch(phoneNoPresenceProvider);
//
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'Fish Seed Exchange',
//         isIconBack: false,
//       ),
//       drawer: HomeDrawer(),
//       body: buildConsumer(),
//       bottomNavigationBar: HomePageBottom(
//         selectedIndex: _selectedIndex,
//         isPhoneNoPresent: _isPhoneNoPresent,
//         onItemTapped: _onItemTapped,
//       ),
//       // selectedIndex: _selectedIndex,
//       // onItemTapped: _onItemTapped,
//     );
//   }
//
//   Consumer buildConsumer() {
//     GoRouter _goRouter = GoRouter.of(context);
//     return Consumer(
//       builder: (context, ref, child) {
//         final List<SeedSaleViewModel>? seedSales =
//         ref.watch(seedSaleViewModelProvider);
//
//         return ListView.builder(
//           itemCount: seedSales?.length ?? 0,
//           itemBuilder: (context, index) {
//             final sale = seedSales?[index];
//             // Get username from the enquiry data
//             final String _phoneNo2 = sale?.userPhoneNumber ?? '';
//             // Check if the phone numbers match
//             final bool _isOwnPhone = _phoneNo1 == _phoneNo2;
//             return Card(
//               child: ListTile(
//                 title: Text(
//                   '# ${sale?.saleId} : ${sale?.userName} - ${sale?.userPhoneNumber}',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Fish : ${sale?.fishName}'),
//                     Text(
//                         'Quantity: ${sale?.fishQuantity},   Rate: Rs ${sale?.rate.toString()} /${sale?.rateUom}'),
//                     Text(
//                         'Netting: ${DateFormat('dd MMM yy').format(sale!.nettingDate)}, Selling: ${DateFormat('dd MMM yy').format(sale.sellingDate)}'),
//                     Text('Remarks: ${sale.remarks}'),
//                     const SizedBox(width: 8),
//                     Row(
//                       children: [
//                         Text('${sale.userType}'),
//                         const Spacer(),
//                         const SizedBox(width: 4),
//                         IconButton(
//                           onPressed: _isOwnPhone
//                               ? null
//                               : () {
//                             leedsDialogFunction(
//                               context: context,
//                               ref: ref,
//                               postType: 'Enquiry',
//                               userPhNo: sale.saleId,
//                               userName: sale.userName,
//                               refId: sale.saleId,
//                               fishName: sale.fishName,
//                               fishQty: sale.fishQuantity,
//                             );
//                           },
//                           icon: FaIcon(
//                             FontAwesomeIcons.fishFins,
//                             color: _isOwnPhone
//                                 ? Colors.grey
//                                 : Colors.teal.shade500,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         IconButton(
//                           onPressed: sale.locationId == "0"
//                               ? null
//                               : () async {
//                             // Debug print to check if onPressed is triggered
//                             debugPrint('IconButton onPressed triggered');
//
//                             // Call locationViewFunction and showAddressFunction
//                             locationViewFunction(
//                               context: context,
//                               ref: ref,
//                               req_type: 'location_id',
//                               req_value: sale.locationId,
//                             );
//                             await showAddressFunction(
//                                 context, ref, sale.locationId);
//
//                             // Debug print to check if functions are called
//                             debugPrint('Functions called');
//                           },
//                           icon: Icon(
//                             Icons.location_on,
//                             color: sale.locationId == '0'
//                                 ? Colors.grey
//                                 : Colors.teal.shade500,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         IconButton(
//                           onPressed: sale.seedPicCount == 0
//                               ? null
//                               : () => fetchPictureViewData(
//                               context, ref, sale.saleId)
//                               .then((_) {
//                             _goRouter.pushNamed(AppRouteConstants
//                                 .pictureViewPageRouteName);
//                           }),
//                           icon: Icon(
//                             Icons.photo_library,
//                             color: sale.seedPicCount == 0
//                                 ? Colors.grey
//                                 : Colors.teal.shade500,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         IconButton(
//                           onPressed: sale.seedVideoCount == 0
//                               ? null
//                               : () =>
//                               fetchVideoViewData(context, ref, sale.saleId)
//                                   .then((_) {
//                                 _goRouter.pushNamed(AppRouteConstants
//                                     .videoViewPageRouteName);
//                               }),
//                           icon: Icon(Icons.video_library,
//                               color: sale.seedVideoCount == 0
//                                   ? Colors.grey
//                                   : Colors.teal.shade500),
//                         ),
//                         // const SizedBox(width: 8),
//                       ],
//                     ),
//                   ],
//                 ),
//                 onTap: () {
//                   // Handle onTap action if needed
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
