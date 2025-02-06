// import 'package:fishseeds/views/appbar/common_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import '../../models/location-list/default_location_model.dart';
// import '../../providers/location-list/location_list_provider.dart';
// import '../../routes/app_route_constants.dart';
// import '../../widgets/launch_google_map.dart';
// import '../../widgets/share_image.dart';
// import '../location/location_remove_function.dart';
// import 'default_location_function.dart';
//
// class LocationListPage extends ConsumerStatefulWidget {
//   @override
//   _LocationListPageState createState() => _LocationListPageState();
// }
//
// class _LocationListPageState extends ConsumerState<LocationListPage> {
//   String _selectedAddressId = '0';
//   final List<GlobalKey> _globalKeys = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize _selectedAddressId with the ID of the active address, if any
//     final addressList = ref.read(locationListModelProvider);
//     for (var address in addressList) {
//       if (address.isActive) {
//         _selectedAddressId = address.addressId;
//         break;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     GoRouter _goRouter = GoRouter.of(context);
//     var addressList = ref.watch(locationListModelProvider);
//
//     final locationNotifier = ref.watch(locationListModelProvider.notifier);
//
//     debugPrint('LocationListPage: Address list length: ${addressList.length}');
//     for (var address in addressList) {
//       debugPrint('LocationListPage: Address: ${address.addressName}');
//     }
//
//     return Stack(
//       children: [
//         Scaffold(
//           appBar: commonAppBar(context, 'Select Location', isIconBack: true),
//           body: Padding(
//             padding: const EdgeInsets.only(bottom: 80),
//             child: addressList.isEmpty
//                 ? Center(child: Text('No addresses available'))
//                 : ListView.builder(
//               itemCount: addressList.length,
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context, index) {
//                 final address = addressList[index];
//                 final key = GlobalKey();
//                 _globalKeys.add(key);
//
//                 return RepaintBoundary(
//                   key: key,
//                   child: Card(
//                     margin: EdgeInsets.all(8.0),
//                     child: ListTile(
//                       title: Text(
//                         '#${address.addressId},  ${address.addressName} - ${address.addressType}',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment
//                             .start, // Aligned to start for better layout
//                         children: [
//                           Text(
//                               'Village : ${address.village}, Panchayat:  ${address.panchayat}'),
//                           Text(
//                               'Mouja : ${address.mouja}, Police Stn: ${address.policeStation}'),
//                           Text(
//                               'District : ${address.district}, Pin: ${address.pinCode}, ${address.state}, '),
//                           Row(
//                             children: [
//                               Spacer(),
//                               IconButton(
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.circleCheck,
//                                   size: 20,
//                                 ),
//                                 color: address.isActive
//                                     ? Colors.purple.shade400
//                                     : Colors.transparent,
//                                 onPressed: () {},
//                               ),
//                               Spacer(),
//                               Radio<String>(
//                                 value: address.addressId,
//                                 groupValue: _selectedAddressId,
//                                 onChanged: (String? value) {
//                                   if (value != null) {
//                                     setState(() {
//                                       _selectedAddressId = value;
//                                     });
//
//                                     locationNotifier.setActiveLocation(
//                                         address.addressId);
//
//                                     DefaultLocationModel _defaultData =
//                                     DefaultLocationModel(
//                                       userPhoneNo: address.userPhoneNo,
//                                       addressId: _selectedAddressId,
//                                     );
//
//                                     defaultLocationData(
//                                       context: context,
//                                       ref: ref,
//                                       defaultData: _defaultData,
//                                     );
//                                   }
//                                 },
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.mapLocation,
//                                   size: 20,
//                                 ),
//                                 color: address.lat > 0 && address.lon > 0
//                                     ? Colors.teal.shade500
//                                     : Colors.grey,
//                                 onPressed: () {
//                                   address.lat > 0 && address.lon > 0
//                                       ? launchGoogleMaps(
//                                     context: context,
//                                     latitude: address.lat,
//                                     longitude: address.lon,
//                                   )
//                                       : null;
//                                 },
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.share,
//                                   size: 20,
//                                   color: Colors.teal.shade500,
//                                 ),
//                                 onPressed: () =>
//                                     _shareImageWithDelay(key),
//                               ),
//                               const SizedBox(width: 8),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.delete,
//                                   size: 20,
//                                   color: address.isActive
//                                       ? Colors.grey
//                                       : Colors.teal.shade500,
//                                 ),
//                                 onPressed: () {
//                                   address.isActive
//                                       ? null
//                                       : removeLocationData(
//                                     context: context,
//                                     ref: ref,
//                                     locationId: address.addressId,
//                                   );
//                                 },
//                               ),
//                               const SizedBox(width: 16),
//                             ],
//                           )
//                         ],
//                       ),
//                       // onTap: () {
//                       //   setState(() {
//                       //     _selectedAddressId = address.addressId;
//                       //     // locationNotifier
//                       //     //     .setActiveLocation(address.addressId);
//                       //   });
//                       // },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         Positioned(
//           left: 0,
//           right: 0,
//           bottom: 16, // Adjust the bottom position as needed
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 16),
//             width: double.infinity,
//             child: FloatingActionButton(
//               tooltip: 'Add Location',
//               onPressed: () {
//                 _goRouter.pushNamed(AppRouteConstants.locationAddPageRouteName);
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.add),
//                   SizedBox(width: 4), // Added space between icon and text
//                   Text(
//                     'Add Location',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> _shareImageWithDelay(GlobalKey key) async {
//     // Add a sufficient delay to ensure the widget is fully rendered
//     await Future.delayed(Duration(milliseconds: 300));
//     shareImage(key);
//   }
// }
