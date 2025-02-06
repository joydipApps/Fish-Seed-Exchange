import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/enquiry/enquiry_view_model.dart';
import '../../models/fish-category/fish_category_model.dart';
import '../../models/fish-list/fish_list_model.dart';
import '../../models/leads/leads_view_model.dart';
import '../../models/seed_sale/seed_sale_view_model.dart';
import '../../providers/enquiry/enquiry_view_provider.dart';
import '../../providers/fish-list/fish_list_provider.dart';
import '../../providers/fish_category/fish_category_provider.dart';
import '../../providers/leads/leads_view_provider.dart';
import '../../providers/local_storage/phone_name_provider.dart';
import '../../providers/local_storage/phone_number_provider.dart';
import '../../providers/local_storage/phoneno_presence_provider.dart';
import '../../providers/location/gps_location_provider.dart';
import '../../providers/seed_sale/seed_sale_view_provider.dart';
import '../../utils/show_progress_dialog.dart';
import '../../widgets/get_gps_location.dart';

Future<void> welcomeFunctions(BuildContext context, WidgetRef ref) async {
  showProgressDialogSync(context); // show Progress

  try {
    _populatePhoneNumber(ref);
    _populatePhoneName(ref);
    _populatePhoneNoPresence(ref);
    await _fetchFishCategoryData(context, ref);
    await _fetchFishListData(context, ref);
    await _updateGpsLocation(context, ref);
    await _fetchSeedSaleData(context, ref);
    await _fetchEnquiryData(context, ref);
    await _fetchLeadsData(context, ref);
  } catch (error) {
    debugPrint('Error in WelcomeFunctions: $error');
    // Handle error if needed
  } finally {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

Future<void> _updateGpsLocation(BuildContext context, WidgetRef ref) async {
  debugPrint('UpdateGpsLocation: Starting update...');
  try {
    Position newPosition = await getGpsLocation(context);
    debugPrint(
        'UpdateGpsLocation: New position retrieved: ${newPosition.latitude}, ${newPosition.longitude}');
    ref.read(gpsLocationProvider.notifier).updateGpsLocation(newPosition);
    debugPrint('UpdateGpsLocation: GPS location updated successfully');
  } catch (e) {
    debugPrint('UpdateGpsLocation: Error updating GPS location: $e');
    // Handle error if needed
  }
}

void _populatePhoneNumber(WidgetRef ref) {
  ref.read(phoneNoProvider.notifier).populatePhoneNo();
}

void _populatePhoneName(WidgetRef ref) {
  ref.read(phoneNameProvider.notifier).populatePhoneName();
}

void _populatePhoneNoPresence(WidgetRef ref) {
  ref.read(phoneNoPresenceProvider.notifier).populatePhoneNoPresence();
}

Future<void> _fetchSeedSaleData(BuildContext context, WidgetRef ref) async {
  if (!ref.read(seedSaleViewSuccessProvider)) {
    try {
      final List<SeedSaleViewModel>? seedSales = await ref
          .read(seedSaleViewServiceProvider)
          .viewSeedSaleDetails(context);

      if (seedSales != null && seedSales.isNotEmpty) {
        debugPrint('Number of SEED-SALES records fetched: ${seedSales.length}');

        ref.read(seedSaleViewModelProvider.notifier).addAllSales(seedSales);
        ref
            .read(seedSaleViewSuccessProvider.notifier)
            .setSeedSaleViewSuccess(true);
      } else {
        debugPrint('No fish data available.');
        // Optionally handle the case where the fish data list is empty or null
      }
    } catch (error) {
      debugPrint('Error fetching Seed Sale data: $error');
    }
  }
}

Future<void> _fetchFishListData(BuildContext context, WidgetRef ref) async {
  try {
    final List<FishListModel>? fishData =
        await ref.read(fishListServiceProvider).fetchFishList(context);

    if (fishData != null && fishData.isNotEmpty) {
      debugPrint('Number of FISH-LIST records fetched: ${fishData.length}');

      ref.read(fishListModelProvider.notifier).setAllFish(fishData);
      ref.read(fishListSuccessProvider.notifier).setFishListSuccess(true);
    } else {
      debugPrint('No fish data available.');
      // Optionally handle the case where the fish data list is empty or null
    }
  } catch (error) {
    debugPrint('Error fetching fish list data: $error');
  }
}

Future<void> _fetchEnquiryData(BuildContext context, WidgetRef ref) async {
  try {
    debugPrint('1. _fetchEnquiryData called'); // Debug point 1

    final List<EnquiryViewModel>? enquiries =
        await ref.read(enquiryViewServiceProvider).enquiryViewDetails(
              context: context,
            );

    if (enquiries != null && enquiries.isNotEmpty) {
      debugPrint('Number of ENQUIRIES records fetched: ${enquiries.length}');

      ref.read(enquiryViewModelProvider.notifier).setAllEnquiries(enquiries);
      ref.read(enquiryViewSuccessProvider.notifier).setEnquiryViewSuccess(true);
    }
  } catch (error) {
    debugPrint('Error fetching enquiry data: $error');
  }
}

Future<void> _fetchFishCategoryData(BuildContext context, WidgetRef ref) async {
  try {
    // Fetch fish category data from the service provider
    final List<FishCategoryModel>? fishData =
        await ref.read(fishCategoryServiceProvider).fetchFishCategory(context);

    if (fishData != null && fishData.isNotEmpty) {
      debugPrint('Number of Category records fetched: ${fishData.length}');
      // Update the state with the fetched data
      ref.read(fishCategoryModelProvider.notifier).addAllCategories(fishData);
      ref
          .read(fishCategorySuccessProvider.notifier)
          .setFishCategorySuccess(true);
    } else {
      debugPrint('No fish data available.');
      // Optionally handle the case where the fish data list is empty or null
    }
  } catch (error) {
    debugPrint('Error fetching fish list data: $error');
  }
}

Future<void> _fetchLeadsData(BuildContext context, WidgetRef ref) async {
  String phoneNo = ref.read(phoneNoProvider);

  try {
    final List<LeadsViewModel>? leads =
        await ref.read(leadsViewServiceProvider).leadsViewDetails(
              context: context,
              userPhNo: phoneNo,
            );

    if (leads != null && leads.isNotEmpty) {
      debugPrint('Number of LEADS records fetched: ${leads.length}');

      ref.read(leadsViewModelProvider.notifier).setAllLeads(leads);
      ref.read(leadsViewSuccessProvider.notifier).setLeadsViewSuccess(true);
    }
  } catch (error) {
    debugPrint('Error fetching leads data: $error');
  }
}
