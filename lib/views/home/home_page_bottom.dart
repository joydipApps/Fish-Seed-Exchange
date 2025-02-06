import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/location-list/location_list_model.dart';
import '../../providers/local_storage/phone_number_provider.dart';
import '../../providers/location-list/location_list_provider.dart';
import '../../routes/app_route_constants.dart';
import '../../utils/show_snack_dialog.dart';
import '../location-list/location_list_function.dart';

class HomePageBottom extends StatelessWidget {
  final int selectedIndex;
  final bool isPhoneNoPresent;
  final Function(int) onItemTapped;

  const HomePageBottom({
    super.key,
    required this.selectedIndex,
    required this.isPhoneNoPresent,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    GoRouter goRouter = GoRouter.of(context);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Enquiry',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.group,
            color: Colors.black,
          ),
          label: 'Leads',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 24.0,
            child: Consumer(
              builder: (context, ref, child) => PopupMenuButton<int>(
                padding: const EdgeInsets.only(bottom: 5),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Add Seed Sale'),
                  ),
                  const PopupMenuItem(
                    value: 2,
                    child: Text('Add Enquiry'),
                  ),
                  // Add more PopupMenuItems as needed
                  const PopupMenuItem(
                    value: 3,
                    child: Text('Picture/Video'),
                  ),
                  const PopupMenuItem(
                    value: 4,
                    child: Text('Location'),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      locationListFunction(
                        context: context,
                        ref: ref,
                        phone_no: ref.read(phoneNoProvider),
                      ).then((_) {
                        // goRouter.pushNamed(
                        //     AppRouteConstants.addSeedSalePageRouteName);
                        final List<LocationListModel> locationList =
                            ref.read(locationListModelProvider);

                        if (locationList.isEmpty) {
                          showSnackDialog(context, 9, 'Enter Location First');
                          GoRouter.of(context).pushNamed(
                              AppRouteConstants.locationAddPageRouteName);
                        } else {
                          GoRouter.of(context).pushNamed(
                              AppRouteConstants.addSeedSalePageRouteName);
                        }
                      });
                      // _goRouter.pushNamed(
                      //     AppRouteConstants.addSeedSalePageRouteName);
                      break;
                    case 2:
                      goRouter
                          .pushNamed(AppRouteConstants.addEnquiryPageRouteName);
                      break;
                    case 3:
                      goRouter
                          .pushNamed(AppRouteConstants.editImagePageRouteName);
                      break;
                    case 4:
                      locationListFunction(
                        context: context,
                        ref: ref,
                        phone_no: ref.read(
                            phoneNoProvider), // Assuming _userPhoneNo is defined somewhere
                      ).then((_) {
                        // Navigation will happen after locationListFunction completes
                        goRouter.pushNamed(
                            AppRouteConstants.locationListPageRouteName);
                      });
                      break;
                    default:
                      // Handle default case
                      break;
                  }
                },
              ),
            ),
          ),
          label: 'More',
        ),
      ],
    );
  }
}
