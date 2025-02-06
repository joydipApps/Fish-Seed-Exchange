import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter-sort/district_name_filter_provider.dart';
import '../../providers/filter-sort/fish_category_filter_provider.dart';
import '../../providers/filter-sort/fish_name_filter_provider.dart';
import '../../providers/filter-sort/group_name_filter_provider.dart';
import '../../providers/filter-sort/selected_district_name_provider.dart';
import '../../providers/filter-sort/selected_fish_category_provider.dart';
import '../../providers/filter-sort/selected_fish_name_provider.dart';
import '../../providers/filter-sort/selected_group_name_provider.dart';
import '../../providers/filter-sort/sort_newest_first_provider.dart';
import '../../providers/filter-sort/sort_on_distance_provider.dart';

void resetAllFilters(WidgetRef ref) {
  // Reset Category Name Filter
  final categoryNameNotifier = ref.read(selectedCategoryNameProvider.notifier);
  categoryNameNotifier.reset();
  ref.read(toggleFishCategoryProvider.notifier).state = false;

  // Reset District Name Filter
  final districtNameNotifier = ref.read(selectedDistrictNameProvider.notifier);
  districtNameNotifier.reset();
  ref.read(toggleDistrictNameProvider.notifier).state = false;

  // Reset Fish Name Filter
  final fishNameNotifier = ref.read(selectedFishNameProvider.notifier);
  fishNameNotifier.reset();
  ref.read(toggleFishNameProvider.notifier).state = false;

  // Reset Group Name Filter
  final groupNameNotifier = ref.read(selectedGroupNameProvider.notifier);
  groupNameNotifier.setSelectedGroupName(null); // Assuming null resets
  ref.read(toggleGroupNameProvider.notifier).state =
      false; // Assuming 'false' resets

  // Reset Sort Newest function
  ref.read(sortNewestFirstProvider.notifier).state =
      false; // Assuming 'false' resets

  // Reset Sort Distance function
  ref.read(sortOnDistanceProvider.notifier).state =
      false; // Assuming 'false' resets
}
