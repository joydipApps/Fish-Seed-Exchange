import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/filter-sort/district_name_filter_provider.dart';
import '../../providers/filter-sort/fish_category_filter_provider.dart';
import '../../providers/filter-sort/fish_name_filter_provider.dart';
import '../../providers/filter-sort/group_name_filter_provider.dart';
import '../../providers/filter-sort/sort_newest_first_provider.dart';
import '../../providers/filter-sort/sort_on_distance_provider.dart';
import '../../routes/app_route_constants.dart';
import '../../utils/constants.dart';
import '../../widgets/social_media.dart';
import '../filter-sort/reset_all_function.dart';
import 'logout_dialog.dart';

AppBar commonAppBar(BuildContext context, String text,
    {bool isIconBack = false, bool isFilterIcon = false}) {
  GoRouter goRouter = GoRouter.of(context);

  return AppBar(
    toolbarHeight: kToolbarHeight,
    leading: isIconBack
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                GoRouter.of(context)
                    .pushNamed(AppRouteConstants.homePageRouteName);
              }
            },
          )
        : Builder(
            builder: (BuildContext builderContext) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(builderContext).openDrawer(); // Open the drawer
                },
              );
            },
          ),
    title: FittedBox(fit: BoxFit.scaleDown, child: Text(text)),
    actions: <Widget>[
      // if (!isIconBack) // Show more options icon only when isIconBack is false
      if (isFilterIcon) // Show more options icon only when isIconBack is false
        Consumer(
          builder: (context, ref, child) {
            final bool isCategoryFilterOn =
                ref.watch(toggleFishCategoryProvider);
            final bool isFishFilterOn = ref.watch(toggleFishNameProvider);
            final bool isDistrictFilterOn =
                ref.watch(toggleDistrictNameProvider);
            final bool isGroupFilterOn = ref.watch(toggleGroupNameProvider);
            final bool isDistanceFilterOn = ref.watch(sortOnDistanceProvider);
            final bool isNewestFilterOn = ref.watch(sortNewestFirstProvider);
            bool isFilterOn = (isCategoryFilterOn ||
                isFishFilterOn ||
                isDistrictFilterOn ||
                isGroupFilterOn ||
                isDistanceFilterOn ||
                isNewestFilterOn);

            return PopupMenuButton<int>(
              icon: Icon(
                Icons.menu_open,
                color: isFilterOn ? Colors.purple.shade500 : Colors.black,
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    'Filter Fish Category',
                    style: TextStyle(
                        color: isCategoryFilterOn
                            ? Colors.purple.shade400
                            : Colors.black),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    'Filter Fish Name',
                    style: TextStyle(
                        color: isFishFilterOn
                            ? Colors.purple.shade400
                            : Colors.black),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    'Filter District',
                    style: TextStyle(
                        color: isDistrictFilterOn
                            ? Colors.purple.shade400
                            : Colors.black),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Text(
                    'Filter Trade Group',
                    style: TextStyle(
                        color: isGroupFilterOn
                            ? Colors.purple.shade400
                            : Colors.black),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 4,
                  child: Text(
                    'Sort by Distance',
                    style: TextStyle(
                        color: isDistanceFilterOn
                            ? Colors.purple.shade400
                            : Colors.black),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 5,
                  child: Text(
                    'Sort Newest First',
                    style: TextStyle(
                        color: isNewestFilterOn
                            ? Colors.purple.shade400
                            : Colors.black),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 6,
                  child: Text(
                    'Reset All',
                    style: TextStyle(
                        color:
                            isFilterOn ? Colors.purple.shade400 : Colors.black),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 0:
                    goRouter.pushNamed(
                        AppRouteConstants.categoryNameFilterPageRouteName);
                    break;
                  case 1:
                    goRouter.pushNamed(
                        AppRouteConstants.fishNameFilterPageRouteName);
                    break;
                  case 2:
                    goRouter.pushNamed(
                        AppRouteConstants.districtNameFilterPageRouteName);
                    break;
                  case 3:
                    goRouter.pushNamed(
                        AppRouteConstants.groupNameFilterPageRouteName);
                    break;
                  case 4:
                    goRouter.pushNamed(
                        AppRouteConstants.sortOnDistancePageRouteName);
                    break;
                  case 5:
                    goRouter.pushNamed(
                        AppRouteConstants.sortNewestFirstPageRouteName);
                    break;
                  case 6:
                    resetAllFilters(ref);
                    break;
                  default:
                    break;
                }
              },
            );
          },
        ),
      IconButton(
        icon: const Icon(
          Icons.share,
          color: Colors.black,
          size: 18,
        ),
        onPressed: () {
          shareContent(context, kShareBody, kShareSubject);
          // showLogoutDialog(context); // Call the logout function
        },
      ),
      IconButton(
        icon: const Icon(
          Icons.exit_to_app,
          color: Colors.black,
        ),
        onPressed: () {
          showLogoutDialog(context); // Call the logout function
        },
      ),
    ],
  );
}
