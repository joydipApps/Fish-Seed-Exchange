import 'package:flutter/scheduler.dart';

import '../../providers/all_providers.dart';
import 'package:geolocator/geolocator.dart';

import '../../providers/filter-sort/fish_category_filter_provider.dart';
import '../../utils/check_count_show_snackbar.dart';
import '../../views/home/show_address_function.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/app_route_constants.dart';
import '../../widgets/calculate_gps_distance.dart';
import '../../widgets/launch_phone_dialer.dart';
import '../../widgets/share_image.dart';
import '../appbar/common_app_bar.dart';
import '../../models/seed_sale/seed_sale_view_model.dart';
import '../filter-sort/reset_all_function.dart';
import '../imagery/picture/picture_view_page.dart';
import '../imagery/video/video_list_page.dart';
import '../leads/leads_dialog_page.dart';
import '../location/location_view_function.dart';
import '../imagery/media/get_picture_function.dart';
import '../imagery/media/get_video_function.dart';
import 'home_drawer.dart';
import 'home_page_bottom.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  // final bool isPhoneNoPresent;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  late bool _isPhoneNoPresent;
  late String _phoneNo1;
  Position? _gpsLocationState;
  final List<GlobalKey> _globalKeys = []; // for share image

  // sorting function
  List<SeedSaleViewModel> sortSalesByIdDescending(
      List<SeedSaleViewModel> sales) {
    sales.sort((a, b) => b.saleId.compareTo(a.saleId));
    return sales;
  }

  @override
  void initState() {
    super.initState();
    // _isPhoneNoPresent = widget.isPhoneNoPresent;
    _phoneNo1 = ref.read(phoneNoProvider);
    _gpsLocationState = ref.read(gpsLocationProvider);
    navigateToDistrictFilterIfNeeded(ref, context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      checkCountAndShowSnackBar(
          context, ref, seedSaleCountProvider, 'Seed Sale');
    });
  }

  void navigateToDistrictFilterIfNeeded(WidgetRef ref, BuildContext context) {
    final showDistrictFilter = ref.read(toggleDistrictNameProvider);

    if (showDistrictFilter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // ref.read(toggleDistrictNameProvider.notifier).state = true;
        GoRouter.of(context)
            .pushNamed(AppRouteConstants.districtNameFilterPageRouteName);
      });
    }
  }

  void _onItemTapped(int index) {
    GoRouter goRouter = GoRouter.of(context);
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding route based on the index
    switch (index) {
      case 0:
        // Call the function to reset all filters and sorts
        resetAllFilters(ref);
        goRouter.pushNamed(AppRouteConstants.homeMenuPageRouteName);
        break;
      case 1:
        goRouter.pushNamed(AppRouteConstants.viewEnquiryPageRouteName);
        break;
      case 2:
        goRouter.pushNamed(AppRouteConstants.viewLeadsPageRouteName);
        break;
      case 3:
        // _goRouter.pushNamed(AppRouteConstants.addSeedSalePageRouteName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _isPhoneNoPresent = ref.watch(phoneNoPresenceProvider);

    return Scaffold(
      appBar: commonAppBar(context, 'Fish Seed Exchange',
          isIconBack: false, isFilterIcon: true),
      drawer: const HomeDrawer(),
      body: buildConsumer(),
      bottomNavigationBar: HomePageBottom(
        selectedIndex: _selectedIndex,
        isPhoneNoPresent: _isPhoneNoPresent,
        onItemTapped: _onItemTapped,
      ),
      // selectedIndex: _selectedIndex,
      // onItemTapped: _onItemTapped,
    );
  }

  Consumer buildConsumer() {
    GoRouter goRouter = GoRouter.of(context);

    return Consumer(
      builder: (context, ref, child) {
        final List<SeedSaleViewModel>? seedSales =
            ref.watch(seedSaleViewModelProvider);

        // Retrieve the selected fish name from the selectedFishNameProvider
        final selectedCategoryName = ref.watch(selectedCategoryNameProvider);
        final selectedFishName = ref.watch(selectedFishNameProvider);
        final selectedDistrictName = ref.watch(selectedDistrictNameProvider);
        final selectedGroupName = ref.watch(selectedGroupNameProvider);
        final sortOnDistance = ref.watch(sortOnDistanceProvider);
        final sortNewestFirst = ref.watch(sortNewestFirstProvider);

        debugPrint('1. Home Page - Selected Fish Name: $selectedFishName');

        // Filter seedSales only if selectedFishName is not null or empty
        List<SeedSaleViewModel>? filteredSeedSales;
        filteredSeedSales = seedSales;
        bool isFilterOn = false;

        if (selectedCategoryName != null && selectedCategoryName.isNotEmpty) {
          filteredSeedSales = filteredSeedSales
              ?.where((sale) => sale.categoryName == selectedCategoryName)
              .toList();
          isFilterOn = true;
        }

        if (selectedFishName != null && selectedFishName.isNotEmpty) {
          filteredSeedSales = filteredSeedSales
              ?.where((sale) => sale.fishName == selectedFishName)
              .toList();
          isFilterOn = true;
        }

        if (selectedDistrictName != null && selectedDistrictName.isNotEmpty) {
          filteredSeedSales = filteredSeedSales
              ?.where((sale) => sale.locationDistrict == selectedDistrictName)
              .toList();
          isFilterOn = true;
        }

        if (selectedGroupName != null && selectedGroupName.isNotEmpty) {
          filteredSeedSales = filteredSeedSales
              ?.where((sale) => sale.userType == selectedGroupName)
              .toList();
          isFilterOn = true;
        }

        // Sort the filtered seed sales based on distance if sortOnDistance is true
        if (sortOnDistance && _gpsLocationState != null) {
          filteredSeedSales?.sort((a, b) {
            double distanceA = calculateGpsDistance(
              _gpsLocationState!.latitude,
              _gpsLocationState!.longitude,
              a.locationLat,
              a.locationLon,
            );
            double distanceB = calculateGpsDistance(
              _gpsLocationState!.latitude,
              _gpsLocationState!.longitude,
              b.locationLat,
              b.locationLon,
            );
            isFilterOn = true;
            return distanceA.compareTo(distanceB);
          });
        }

        // sort on id descending
        if (sortNewestFirst) {
          isFilterOn = true;
          filteredSeedSales = sortSalesByIdDescending(filteredSeedSales ?? []);
        }

        // Filter and sort section ends

        return ListView.builder(
          itemCount: filteredSeedSales?.length ?? 0,
          itemBuilder: (context, index) {
            final sale = filteredSeedSales?[index];
            // Get username from the enquiry data
            final String phoneNo2 = sale?.userPhoneNumber ?? '';
            // Check if the phone numbers match
            final bool isOwnPhone = _phoneNo1 == phoneNo2;
            final key = GlobalKey(); // for share image
            _globalKeys.add(key); // for share image

            return RepaintBoundary(
              key: key,
              child: Card(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Text(
                              '# ${sale?.saleId} : ${sale?.userName} - ${sale?.userPhoneNumber}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text('Category : ${sale?.categoryName}'),
                      Text(
                          'Fish Type: ${sale?.categoryName} - ${sale?.fishName}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          'Quantity: ${sale?.fishQuantity} ${sale?.qtyUom},   Rate: Rs ${sale?.rate.toString()} /${sale?.qtyUom}'),
                      Text(
                          'Netting: ${DateFormat('dd MMM yy').format(sale!.nettingDate)}, Selling: ${DateFormat('dd MMM yy').format(sale.sellingDate)}'),
                      Text('Remarks: ${sale.remarks}'),
                      // Text('Location Id: ${sale.locationId}'),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person,
                              // size: 20,
                              color: Colors.teal.shade500),
                          const SizedBox(width: 4),
                          Text(
                            '${sale.userType} ',
                            style: const TextStyle(fontStyle: FontStyle.italic),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                          const SizedBox(width: 8),
                          FaIcon(
                            FontAwesomeIcons.road,
                            size: 16,
                            color: Colors.teal.shade500,
                          ),
                          const SizedBox(width: 4),
                          if (_gpsLocationState != null) ...[
                            Text(
                              '${calculateGpsDistance(
                                _gpsLocationState!.latitude,
                                _gpsLocationState!.longitude,
                                sale.locationLat,
                                sale.locationLon,
                              )} Km',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.phone,
                              size: 16,
                            ),
                            color:
                                isOwnPhone ? Colors.grey : Colors.teal.shade500,
                            onPressed: isOwnPhone
                                ? null
                                : () {
                                    launchPhoneDialer(
                                      context: context,
                                      phNo: sale.userPhoneNumber,
                                    );
                                  },
                          ),
                          const Text(
                            'Call',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          if (isFilterOn)
                            Icon(
                              Icons.filter,
                              size: 20,
                              color: Colors.purple.shade400,
                            ),
                          const SizedBox(width: 0),
                          if (isFilterOn)
                            Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.purple.shade400,
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: isOwnPhone
                                ? null
                                : () {
                                    // Navigate to LeadsDialogPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LeadsDialogPage(
                                          // userPhNo: sale.userPhoneNumber,
                                          // userName: sale.userName,
                                          postType: 'Seeds',
                                          refId: sale.saleId,
                                          categoryName: sale.categoryName,
                                          fishName: sale.fishName,
                                          fishQty: sale.fishQuantity,
                                        ),
                                      ),
                                    );
                                  },
                            icon: FaIcon(
                              FontAwesomeIcons.basketShopping,
                              size: 18,
                              color: isOwnPhone
                                  ? Colors.grey
                                  : Colors.teal.shade500,
                            ),
                          ),
                          const SizedBox(width: 0),
                          // todo open location in  next version
                          IconButton(
                            onPressed: sale.locationId == "0"
                                ? null
                                : () async {
                                    // Debug print to check if onPressed is triggered
                                    debugPrint(
                                        'IconButton onPressed triggered');

                                    await locationViewFunction(
                                      context: context,
                                      ref: ref,
                                      req_type: 'location_id',
                                      req_value: sale.locationId,
                                    );

                                    await showAddressFunction(
                                        context, ref, sale.locationId);

                                    // Debug print to check if functions are called
                                    debugPrint('Functions called');
                                  },
                            icon: FaIcon(
                              FontAwesomeIcons.addressCard,
                              size: 18,
                              color: sale.locationId == '0'
                                  ? Colors.grey
                                  : Colors.teal.shade500,
                            ),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            onPressed: sale.seedPicCount == 0
                                ? null
                                : () => fetchPictureViewData(
                                            context, ref, sale.saleId)
                                        .then((_) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => PictureViewPage(
                                          saleId: sale.saleId,
                                        ),
                                      ));
                                      // goRouter.pushNamed(AppRouteConstants
                                      //     .pictureViewPageRouteName);
                                    }),
                            icon: Icon(
                              Icons.photo_library,
                              size: 20,
                              color: sale.seedPicCount == 0
                                  ? Colors.grey
                                  : Colors.teal.shade500,
                            ),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            onPressed: sale.seedVideoCount == 0
                                ? null
                                : () => fetchVideoViewData(context, ref,
                                            sale.saleId, sale.userPhoneNumber)
                                        .then((_) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VideoListPage(
                                          saleId: sale.saleId,
                                        ),
                                      ));
                                    }),
                            // todo change routing
                            icon: Icon(Icons.video_library,
                                size: 20,
                                color: sale.seedVideoCount == 0
                                    ? Colors.grey
                                    : Colors.teal.shade500),
                          ),
                          const SizedBox(width: 0),
                          IconButton(
                            onPressed: () => _shareImageWithDelay(key),
                            icon: Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.teal.shade500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  // onTap: () {
                  //   // Handle onTap action if needed
                  // },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _shareImageWithDelay(GlobalKey key) async {
    // Add a sufficient delay to ensure the widget is fully rendered
    await Future.delayed(const Duration(milliseconds: 300));
    await shareImage(key);
  }
}
