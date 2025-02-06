// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../providers/phoneno_presense_provider.dart';
// import '../../routes/app_route_constants.dart';
// import '../../widgets/common_app_bar.dart';
// import '../../models/seed_sale_view_model.dart';
// import '../../providers/seed_sale_view_provider.dart';
//
// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   HomePageState createState() => HomePageState();
// }
//
// class HomePageState extends ConsumerState<HomePage> {
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAndPopulateData();
//   }
//
//   void _fetchAndPopulateData() async {
//     if (!ref.read(seedSaleViewSuccessProvider)) {
//       final List<SeedSaleViewModel>? seedSales =
//       await ref.read(seedSaleViewServiceProvider).viewSeedSaleDetails();
//
//       if (seedSales != null && seedSales.isNotEmpty) {
//         ref.read(seedSaleViewModelProvider.notifier).addAllSales(seedSales);
//         ref
//             .read(seedSaleViewSuccessProvider.notifier)
//             .setSeedSaleViewSuccess(true);
//       }
//     }
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//         GoRouter.of(context).pushNamed(AppRouteConstants.homePageRouteName);
//         break;
//       case 1:
//         GoRouter.of(context).pushNamed(AppRouteConstants.comingSoonRouteName);
//         break;
//       case 2:
//         GoRouter.of(context)
//             .pushNamed(AppRouteConstants.addPicturePageRouteName);
//         break;
//       case 3:
//         GoRouter.of(context)
//             .pushNamed(AppRouteConstants.seedSaleEntryPageRouteName);
//         break;
//       case 4:
//         GoRouter.of(context).pushNamed(AppRouteConstants.registerUserRouteName);
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: commonAppBar(context, 'Fish Seeds', isIconBack: false),
//       body: Consumer(
//         builder: (context, ref, child) {
//           final List<SeedSaleViewModel>? seedSales =
//           ref.watch(seedSaleViewModelProvider);
//           return ListView.builder(
//             itemCount: seedSales?.length ?? 0,
//             itemBuilder: (context, index) {
//               final sale = seedSales?[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(
//                       'Name : ${sale?.userName} - ${sale?.userPhoneNumber}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                           'Village : null'), // Replace 'null' with actual value
//                       Text('Fish : ${sale?.fishName}'),
//                       Text(
//                           'Quantity: ${sale?.fishQuantity},   Rate: Rs ${sale?.rate.toString()} /${sale?.rateUom}'),
//                       Text(
//                           'Netting: ${DateFormat('dd MMM yy').format(sale!.nettingDate)}, Selling: ${DateFormat('dd MMM yy').format(sale.sellingDate)}'),
//                       Text('Remarks: ${sale.remarks}'),
//                       const SizedBox(width: 8),
//                       Row(
//                         children: [
//                           Text('##: ${sale.saleId}'),
//                           const Spacer(),
//                           const SizedBox(width: 8),
//                           IconButton(
//                             onPressed: sale.seedPicCount != 0
//                                 ? null
//                                 : () {
//                               // Action for the pictures button
//                             },
//                             icon: const Icon(Icons.location_on),
//                           ),
//                           const SizedBox(width: 8),
//                           IconButton(
//                             onPressed: sale.seedPicCount == 0
//                                 ? null
//                                 : () {
//                               // Action for the pictures button
//                             },
//                             icon: const Icon(Icons.photo_library),
//                           ),
//                           const SizedBox(width: 8),
//                           IconButton(
//                             onPressed: sale.seedVideoCount == 0
//                                 ? null
//                                 : () {
//                               // Action for the videos button
//                             },
//                             icon: const Icon(Icons.video_library),
//                           ),
//                           const SizedBox(width: 8),
//                         ],
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     // Handle onTap action if needed
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       bottomNavigationBar: buildBottomNavigationBar(),
//     );
//   }
//
//   Widget buildBottomNavigationBar() {
//     return Consumer(
//       builder: (context, watch, child) {
//         final isPhoneNoPresentFuture =
//         ref.watch(phoneNoPresenceProvider.future);
//
//         return FutureBuilder<bool>(
//           future: isPhoneNoPresentFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else {
//               final bool isPhoneNoPresent = snapshot.data ?? false;
//               return BottomNavigationBar(
//                 currentIndex: _selectedIndex,
//                 onTap: _onItemTapped,
//                 items: [
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.home),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.event),
//                     label: 'Enquiry',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Icons.image,
//                       color: isPhoneNoPresent
//                           ? Colors.black
//                           : Colors.redAccent.shade700,
//                     ),
//                     label: 'Picture',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Icons.settings,
//                       color: isPhoneNoPresent
//                           ? Colors.black
//                           : Colors.redAccent.shade700,
//                     ),
//                     label: 'Seeds',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(
//                       Icons.person,
//                       color: isPhoneNoPresent
//                           ? Colors.black
//                           : Colors.redAccent.shade700,
//                     ),
//                     label: isPhoneNoPresent ? 'Registered' : 'Register',
//                     tooltip: "Name and Phone No",
//                   ),
//                 ],
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }
