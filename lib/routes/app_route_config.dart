import '../views/common/privacy_policy.dart';
import '../views/common/rate_app_page.dart';
import '../views/filter-sort/category_name_filter_page.dart';
import '../views/home/home_menu.dart';
import '../views/home/home_page_guest.dart';
import '../views/imagery/video/video_list_page.dart';
import '../views/leads/leads_dialog_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/filter-sort/district_name_filter_page.dart';
import '../views/filter-sort/fish_name_filter_page.dart';
import '../views/filter-sort/group_name_filter_page.dart';
import '../views/filter-sort/sort_newest_first_page.dart';
import '../views/filter-sort/sort_on_distance_page.dart';
import '../views/enquiry/enquiry_view_page.dart';
import '../views/home/show_address_page.dart';
import '../views/leads/leads_view_page.dart';
import '../views/location-list/location_list_page.dart';
import '../views/location/location_add_page.dart';

import '../views/common/about_us_page.dart';
import '../views/common/contact_us_page.dart';
import '../views/common/error.dart';
import '../views/common/package_info_page.dart';
import '../views/common/terms_and_conditions_page.dart';
import '../views/enquiry/enquiry_add_page.dart';
import '../views/home/home_page.dart';
import '../views/imagery/picture/picture_add_page.dart';
import '../views/imagery/picture/picture_view_page.dart';
import '../views/imagery/video/video_view_page.dart';
import '../views/imagery/media/edit_image_page.dart';
import '../views/register/register_user_page.dart';
import '../views/seeds/seed_sale_entry_page.dart';
import '../views/welcome/splash_screen.dart';
import '../views/welcome/welcome_page.dart';
import 'app_route_constants.dart';

// GoRouter configuration
class MyAppRouteConfig {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
// Splash Screen
      GoRoute(
          name: AppRouteConstants.splashScreenRouteName,
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SplashScreen())),

      // root - welcome page
      GoRoute(
          name: AppRouteConstants.welcomePageRouteName,
          path: '/welcome',
          pageBuilder: (context, state) =>
              const MaterialPage(child: WelcomePage())),

      GoRoute(
          name: AppRouteConstants.homePageRouteName,
          path: '/home',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomePage())),

      GoRoute(
          name: AppRouteConstants.homeMenuPageRouteName,
          path: '/homeMenu',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomeMenuPage())),

      GoRoute(
          name: AppRouteConstants.homeGuestPageRouteName,
          path: '/homePageGuest',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomePageGuest())),

      GoRoute(
          name: AppRouteConstants.showAddressPageRouteName,
          path: '/showAddress',
          pageBuilder: (context, state) => const MaterialPage(
                  child: ShowAddressPage(
                locationId: '',
              ))),

      GoRoute(
          name: AppRouteConstants.registerUserRouteName,
          path: '/register',
          pageBuilder: (context, state) =>
              const MaterialPage(child: RegisterUser())),

      GoRoute(
          name: AppRouteConstants.addSeedSalePageRouteName,
          path: '/seedSale',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SeedSaleEntryPage())),
// media

      GoRoute(
          name: AppRouteConstants.editImagePageRouteName,
          path: '/editImage',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EditImagePage())),

// Enquiry

      GoRoute(
          name: AppRouteConstants.addEnquiryPageRouteName,
          path: '/addEnquiry',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EnquiryAddPage())),

      GoRoute(
          name: AppRouteConstants.viewEnquiryPageRouteName,
          path: '/viewEnquiry',
          pageBuilder: (context, state) =>
              const MaterialPage(child: EnquiryViewPage())),

// Filters

      GoRoute(
          name: AppRouteConstants.categoryNameFilterPageRouteName,
          path: '/categoryNameFilter',
          pageBuilder: (context, state) =>
              const MaterialPage(child: CategoryNameFilterPage())),

      GoRoute(
          name: AppRouteConstants.fishNameFilterPageRouteName,
          path: '/fishNameFilter',
          pageBuilder: (context, state) =>
              const MaterialPage(child: FishNameFilterPage())),

      GoRoute(
          name: AppRouteConstants.groupNameFilterPageRouteName,
          path: '/groupNameFilter',
          pageBuilder: (context, state) =>
              const MaterialPage(child: GroupNameFilterPage())),

      GoRoute(
          name: AppRouteConstants.districtNameFilterPageRouteName,
          path: '/districtNameFilter',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DistrictNameFilterPage())),

      // GoRoute(
      //     name: AppRouteConstants.districtChoiceFilterPageRouteName,
      //     path: '/districtChoiceFilter',
      //     pageBuilder: (context, state) => const MaterialPage(
      //             child: DistrictChoiceFilterPage(
      //           catId: '',
      //         ))),

      GoRoute(
          name: AppRouteConstants.sortOnDistancePageRouteName,
          path: '/sortOnDistance',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SortOnDistancePage())),

      GoRoute(
          name: AppRouteConstants.sortNewestFirstPageRouteName,
          path: '/sortNameFirstPage',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SortNewestFirstPage())),

// Leads

      //leadsDialogPageRouteName
      GoRoute(
          name: AppRouteConstants.viewLeadsPageRouteName,
          path: '/viewLeads',
          pageBuilder: (context, state) =>
              const MaterialPage(child: LeadsViewPage())),

      GoRoute(
          name: AppRouteConstants.leadsDialogPageRouteName,
          path: '/leadsDialog',
          pageBuilder: (context, state) => const MaterialPage(
                  child: LeadsDialogPage(
                // userPhNo: '',
                // userName: '',
                postType: '',
                refId: '',
                categoryName: '',
                fishName: '',
                fishQty: 0,
              ))),

// Imagery

      // GoRoute(
      //     name: AppRouteConstants.pictureViewPageRouteName,
      //     path: '/viewPicture',
      //     pageBuilder: (context, state) => const MaterialPage(
      //             child: PictureViewPage(
      //           saleId: '',
      //         ))),

      GoRoute(
          name: AppRouteConstants.pictureAddPageRouteName,
          path: '/addPicture',
          pageBuilder: (context, state) => const MaterialPage(
                  child: PictureAddPage(
                saleId: '',
                phoneNumber: '',
                seedPicCount: 0,
              ))),

      // GoRoute(
      //     name: AppRouteConstants.videoViewPageRouteName,
      //     path: '/viewVideo',
      //     pageBuilder: (context, state) =>
      //         const MaterialPage(child: VideoViewPage())),
      //todo change list to view

      // GoRoute(
      //     name: AppRouteConstants.videoListPageRouteName,
      //     path: '/listVideo',
      //     pageBuilder: (context, state) => const MaterialPage(
      //             child: VideoListPage(
      //           saleId: '',
      //         ))),

// PictureAddPage
// Studio

      // GoRoute(
      //     name: AppRouteConstants.imageInputCameraRouteName,
      //     path: '/imageInputCamera',
      //     pageBuilder: (context, state) =>
      //         MaterialPage(child: ImageInputCamera(onImageSelected: (File image) {  },)))),

      // GoRoute(
      //     name: AppRouteConstants.imageInputGalleryRouteName,
      //     path: '/imageInputGallery',
      //     pageBuilder: (context, state) =>
      //         MaterialPage(child: ImageInputGallery(onImageSelected: (File image) {  },))),

      // GoRoute(
      //     name: AppRouteConstants.imageSelectionRouteName,
      //     path: '/imageSelection',
      //     pageBuilder: (context, state) =>
      //         MaterialPage(child: ImageSelectionWidget())),

      // GoRoute(
      //     name: AppRouteConstants.imageInputRouteName,
      //     path: '/imageInput',
      //     pageBuilder: (context, state) => const MaterialPage(
      //             child: ImageInput(
      //           device: null,
      //         ))),

      // AddPicturePage

      // Location Pages
      GoRoute(
          name: AppRouteConstants.locationAddPageRouteName,
          path: '/locationAdd',
          pageBuilder: (context, state) =>
              const MaterialPage(child: LocationSavePage())),

      // GoRoute(
      //     name: AppRouteConstants.locationViewPageRouteName,
      //     path: '/LocationView',
      //     pageBuilder: (context, state) =>
      //         const MaterialPage(child: LocationViewPage())),

      GoRoute(
          name: AppRouteConstants.locationListPageRouteName,
          path: '/LocationList',
          pageBuilder: (context, state) =>
              const MaterialPage(child: LocationListPage())),

      // Common
      GoRoute(
          name: AppRouteConstants.aboutUsPageRouteName,
          path: '/about',
          pageBuilder: (context, state) =>
              const MaterialPage(child: AboutUsPage())),
      GoRoute(
          name: AppRouteConstants.privacyPolicyPageRouteName,
          path: '/privacyPolicy',
          pageBuilder: (context, state) =>
              const MaterialPage(child: PrivacyPolicyPage())),

      GoRoute(
          name: AppRouteConstants.contactUsPageRouteName,
          path: '/contact',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ContactUsPage())),

      GoRoute(
          name: AppRouteConstants.rateAppPageRouteName,
          path: '/rateApp',
          pageBuilder: (context, state) =>
              const MaterialPage(child: RateAppPage())),

      GoRoute(
          name: AppRouteConstants.termsAndConditionsPageRouteName,
          path: '/terms',
          pageBuilder: (context, state) =>
              const MaterialPage(child: TermsAndConditionsPage())),

      GoRoute(
          name: AppRouteConstants.packageInfoPageRouteName,
          path: '/package-info',
          pageBuilder: (context, state) =>
              const MaterialPage(child: DeviceInfoPage())),

      GoRoute(
          name: AppRouteConstants.errorPageRouteName,
          path: '/common',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ErrorPage())),

      // Testing new routes:
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );
}

// AppRouteConstants.upcomingEvents
