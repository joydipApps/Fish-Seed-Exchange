// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../models/fish-category/fish_category_model.dart';
// import '../../providers/filter-sort/fish_category_filter_provider.dart';
// import '../../providers/filter-sort/selected_fish_category_provider.dart';
// import '../../providers/fish_category/fish_category_provider.dart';
// import '../../routes/app_route_constants.dart';
// import '../appbar/common_app_bar.dart';
//
// class HomeMenuPage extends ConsumerWidget {
//   const HomeMenuPage({super.key});
//
//   void updateSelectedCategoryName(WidgetRef ref, String catId) {
//     // Access the list of FishCategoryModel
//     final fishCategories = ref.watch(fishCategoryModelProvider);
//
//     // Find the category with the provided categoryId
//     final selectedCategory = fishCategories.firstWhere(
//           (category) => category.categoryId == catId,
//       orElse: () => FishCategoryModel(
//           categoryId: '', categoryName: ''), // Provide a default empty instance
//     );
//
//     // Use the setSelectedCategoryName method to update the state
//     if (selectedCategory.categoryId.isNotEmpty) {
//       ref
//           .read(selectedCategoryNameProvider.notifier)
//           .setSelectedCategoryName(selectedCategory.categoryName);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     GoRouter goRouter = GoRouter.of(context);
//     return Scaffold(
//       appBar: commonAppBar(
//         context,
//         'Fish Seed Exchange',
//         isIconBack: false,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Card for 'Fish Exchange'
//             Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('All fish Store - সব ধরনের মাছ'),
//                 leading: const FaIcon(FontAwesomeIcons.store,
//                     color: Colors.teal, size: 20), // Example icon
//                 onTap: () {
//                   ref.read(toggleFishCategoryProvider.notifier).state = true;
//                   goRouter.goNamed(
//                     AppRouteConstants.homePageRouteName,
//                   );
//                 },
//               ),
//             ),
//             // Card for 'Fish eggs and fry - ডিম পোনা'
//             Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('Fish eggs and fry - ডিম পোনা'),
//                 leading: const FaIcon(FontAwesomeIcons.fishFins,
//                     color: Colors.teal, size: 20), // Example icon
//                 onTap: () {
//                   goRouter.goNamed(
//                       AppRouteConstants.districtChoiceFilterPageRouteName);
//                   ref.read(toggleFishCategoryProvider.notifier).state = true;
//                   updateSelectedCategoryName(ref, 'C1');
//                   Future.delayed(const Duration(milliseconds: 500), () {
//                     goRouter.goNamed(AppRouteConstants.homePageRouteName);
//                   });
//                 },
//               ),
//             ),
//
//             // Card for 'Fish fingerlings - মাছের চারা'
//             Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('Fish fingerlings - মাছের চারা'),
//                 leading: const FaIcon(FontAwesomeIcons.fishFins,
//                     color: Colors.teal, size: 20), // Example icon
//                 onTap: () {
//                   ref.read(toggleFishCategoryProvider.notifier).state = true;
//                   updateSelectedCategoryName(ref, 'C2');
//                   goRouter.goNamed(
//                     AppRouteConstants.homePageRouteName,
//                   );
//                 },
//               ),
//             ),
//             // Card for 'Marketable fish - বাজার জাত মার মাছ'
//             Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 4,
//               child: ListTile(
//                 title: const Text('Marketable fish - বাজার জাত মাছ'),
//                 leading: const FaIcon(
//                   FontAwesomeIcons.fishFins,
//                   color: Colors.teal,
//                   size: 20,
//                 ), // Example icon
//                 onTap: () {
//                   updateSelectedCategoryName(ref, 'C3');
//                   ref.read(toggleFishCategoryProvider.notifier).state = true;
//                   goRouter.goNamed(
//                     AppRouteConstants.homePageRouteName,
//                   );
//                 },
//               ),
//             ),
//             // Card for 'Net party, fishing - জাল পার্টি, মাছ ধরা'
//             // Card(
//             //   margin: const EdgeInsets.all(10),
//             //   elevation: 4,
//             //   child: ListTile(
//             //     title: const Text('Net fishing party  - জাল পার্টি, মাছ ধরা'),
//             //     leading: const FaIcon(
//             //       FontAwesomeIcons.person,
//             //       color: Colors.teal,
//             //       size: 20,
//             //     ), // Example icon
//             //     onTap: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (context) => NetPartyFishingPage(),
//             //         ),
//             //       );
//             //     },
//             //   ),
//             // ),
//             // Card for 'Fish water cart - জল দাওয়া মাছের গাড়ি'
//             // Card(
//             //   margin: const EdgeInsets.all(10),
//             //   elevation: 4,
//             //   child: ListTile(
//             //     title: const Text('Fish water cart - জল দাওয়া মাছের গাড়ি'),
//             //     leading: const FaIcon(
//             //       FontAwesomeIcons.truck,
//             //       color: Colors.teal,
//             //       size: 20,
//             //     ), // Example icon
//             //     onTap: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (context) => const FishWaterCartPage(),
//             //         ),
//             //       );
//             //     },
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Sample page classes
// // class FishEggsAndFryPage extends StatelessWidget {
// //   const FishEggsAndFryPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Fish eggs and fry - ডিম পোনা'),
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'Details for Fish eggs and fry - ডিম পোনা',
// //           style: TextStyle(fontSize: 24),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // Repeat similar structure for other pages:
// // class FishFingerlingsPage extends StatelessWidget {
// //   const FishFingerlingsPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Fish fingerlings - মাছের চারা'),
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'Details for Fish fingerlings - মাছের চারা',
// //           style: TextStyle(fontSize: 24),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class MarketableFishPage extends StatelessWidget {
// //   const MarketableFishPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Marketable fish - বাজার জাত মার মাছ'),
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'Details for Marketable fish - বাজার জাত মার মাছ',
// //           style: TextStyle(fontSize: 24),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class NetPartyFishingPage extends StatelessWidget {
// //   const NetPartyFishingPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Net party, fishing - জাল পার্টি, মাছ ধরা'),
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'Details for Net party, fishing - জাল পার্টি, মাছ ধরা',
// //           style: TextStyle(fontSize: 24),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // class FishWaterCartPage extends StatelessWidget {
// //   const FishWaterCartPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Fish water cart - জল দাওয়া মাছের গাড়ি'),
// //       ),
// //       body: const Center(
// //         child: Text(
// //           'Details for Fish water cart - জল দাওয়া মাছের গাড়ি',
// //           style: TextStyle(fontSize: 24),
// //         ),
// //       ),
// //     );
// //   }
// // }
