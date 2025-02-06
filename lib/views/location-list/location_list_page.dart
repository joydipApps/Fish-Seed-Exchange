import '../../views/appbar/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../models/location-list/default_location_model.dart';
import '../../providers/location-list/location_list_provider.dart';
import '../../routes/app_route_constants.dart';
import '../../widgets/launch_google_map.dart';
import '../../widgets/share_image.dart';
import '../location/location_remove_function.dart';
import 'default_location_function.dart';

class LocationListPage extends ConsumerStatefulWidget {
  const LocationListPage({super.key});

  @override
  LocationListPageState createState() => LocationListPageState();
}

class LocationListPageState extends ConsumerState<LocationListPage> {
  String _selectedAddressId = '0';

  @override
  void initState() {
    super.initState();
    // Initialize _selectedAddressId with the ID of the active address, if any
    final addressList = ref.read(locationListModelProvider);
    for (var address in addressList) {
      if (address.isActive) {
        _selectedAddressId = address.locationId;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    GoRouter goRouter = GoRouter.of(context);
    var addressList = ref.watch(locationListModelProvider);
    final locationNotifier = ref.watch(locationListModelProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          appBar: commonAppBar(context, 'Select Location', isIconBack: true),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: addressList.isEmpty
                ? const Center(child: Text('No addresses available'))
                : ListView.builder(
                    itemCount: addressList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final address = addressList[index];
                      final key = GlobalKey();

                      return RepaintBoundary(
                        key: key,
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              '#${address.locationId},  ${address.locationName} - ${address.locationType}',
                              textAlign: TextAlign.left,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Village : ${address.village}, Panchayat:  ${address.panchayat}'),
                                Text(
                                    'Mouja : ${address.mouja}, Police Stn: ${address.policeStation}'),
                                Text(
                                    'District : ${address.district}, Pin: ${address.pinCode}, ${address.state}, '),
                                Row(
                                  children: [
                                    const Spacer(),
                                    if (address.isActive)
                                      FaIcon(
                                        FontAwesomeIcons.circleCheck,
                                        size: 20,
                                        color: Colors.purple.shade400,
                                      ),

                                    const Spacer(),
                                    Radio<String>(
                                      value: address.locationId,
                                      groupValue: _selectedAddressId,
                                      onChanged: (String? value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedAddressId = value;
                                          });

                                          locationNotifier.setActiveLocation(
                                              address.locationId);

                                          DefaultLocationModel defaultData =
                                              DefaultLocationModel(
                                            userPhoneNo: address.userPhoneNo,
                                            addressId: _selectedAddressId,
                                          );

                                          defaultLocationData(
                                            context: context,
                                            ref: ref,
                                            defaultData: defaultData,
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    // IconButton(
                                    //   icon: const FaIcon(
                                    //     FontAwesomeIcons.mapLocation,
                                    //     size: 20,
                                    //   ),
                                    //   color: address.lat > 0 && address.lon > 0
                                    //       ? Colors.teal.shade500
                                    //       : Colors.grey,
                                    //   onPressed: () {
                                    //     address.lat > 0 && address.lon > 0
                                    //         ? launchGoogleMaps(
                                    //             context: context,
                                    //             latitude: address.lat,
                                    //             longitude: address.lon,
                                    //           )
                                    //         : null;
                                    //   },
                                    // ),
                                    // const SizedBox(width: 8),
                                    IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        size: 20,
                                        color: Colors.teal.shade500,
                                      ),
                                      onPressed: () =>
                                          _shareImageWithDelay(key),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: address.isActive
                                            ? Colors.grey
                                            : Colors.teal.shade500,
                                      ),
                                      onPressed: () {
                                        if (!address.isActive) {
                                          removeLocationData(
                                            context: context,
                                            ref: ref,
                                            locationId: address.locationId,
                                          ).then((_) {
                                            // After deletion, update the provider
                                            // Remove the location from the list
                                            locationNotifier.removeLocation(
                                                address.locationId);
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: FloatingActionButton(
              tooltip: 'Add Location',
              onPressed: () {
                goRouter.pushNamed(AppRouteConstants.locationAddPageRouteName);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 4),
                  Text(
                    'Add Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _shareImageWithDelay(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 300));
    await shareImage(key);
  }
}
