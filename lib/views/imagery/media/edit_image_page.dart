import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/seed_sale/seed_sale_view_model.dart';
import '../../../providers/imagery/media/picture_count_provider.dart';
import '../../../providers/imagery/media/video_count_provider.dart';
import '../../../providers/local_storage/phone_number_provider.dart';
//import '../../providers/local_storage/phoneno_presence_provider.dart';
import '../../../providers/seed_sale/seed_sale_view_provider.dart';
import '../../../routes/app_route_constants.dart';
import '../../../utils/constants.dart';
import '../../appbar/common_app_bar.dart';

import '../picture/picture_add_page.dart';
import '../picture/picture_view_page.dart';
import '../video/video_add_page.dart';
import '../video/video_list_page.dart';
import 'get_picture_function.dart';
import 'get_video_function.dart';

class EditImagePage extends ConsumerStatefulWidget {
  const EditImagePage({super.key});

  @override
  ConsumerState<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends ConsumerState<EditImagePage> {
  String storedPhone = '';
  //bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GoRouter goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: commonAppBar(context, 'Add Pictures / Videos', isIconBack: true),
      body: Consumer(
        builder: (context, ref, child) {
          //final isPhoneNoPresent = ref.watch(phoneNoPresenceProvider);

          final String phoneNumber = ref.watch(phoneNoProvider);
          final seedSales = ref.watch(seedSaleViewModelProvider);

          // Filter seedSales based on storedPhone
          final filteredSeedSales = seedSales.where((sale) {
            // Add print statements to debug sale.userPhoneNumber and storedPhone
            debugPrint('Sale Phone: ${sale.userPhoneNumber}');
            debugPrint('Stored Phone: $storedPhone');
            // Return true if the phone numbers match, false otherwise
            return sale.userPhoneNumber == phoneNumber;
            // return sale.userPhoneNumber == storedPhone;
          }).toList();

          // Add debug statement to print filtered seed sales count
          debugPrint('Filtered Seed Sales Count: ${filteredSeedSales.length}');

          return filteredSeedSales.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredSeedSales.length,
                  itemBuilder: (context, index) {
                    final sale = filteredSeedSales[index];

                    final pictureCount =
                        ref.watch(salePictureCounterProvider(sale.saleId));
                    final videoCount =
                        ref.watch(saleVideoCounterProvider(sale.saleId));

                    debugPrint(
                        "Count of Pic for id ${sale.saleId}: : ${sale.seedPicCount}"); // Place it here
                    debugPrint(
                        "Count of Video for id ${sale.saleId}: : ${sale.seedVideoCount}");
                    return Card(
                      child: ListTile(
                        title: Text(
                            '#: ${sale.saleId}   : ${sale.userName} - ${sale.userPhoneNumber}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Text('Village : ${sale.village}'),
                            Text(
                                'Fish Type: ${sale.categoryName} - ${sale.fishName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(
                                'Quantity: ${sale.fishQuantity},   Rate: Rs ${sale.rate.toString()} /${sale.qtyUom}'),
                            Text(
                                'Netting: ${DateFormat('dd MMM yy').format(sale.nettingDate)}, Selling: ${DateFormat('dd MMM yy').format(sale.sellingDate)}'),
                            Text('Remarks: ${sale.remarks}'),
                            const SizedBox(height: 8),
                            Text(
                                'debugPrint Pic:  ${sale.seedPicCount} Video: ${sale.seedVideoCount}'),
                            Text(
                                'debugPrint Pic:  $pictureCount Video: $videoCount'),
                            const Text(
                                'debugPrint MaxPic:  $kMaxPicture MaxVideo: $kMaxVideo'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // View group
                                Row(
                                  children: [
                                    const RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'View: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: pictureCount <= 0
                                          ? null
                                          : () => fetchPictureViewData(
                                                      context, ref, sale.saleId)
                                                  .then((_) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      PictureViewPage(
                                                    saleId: sale.saleId,
                                                  ),
                                                ));
                                              }),
                                      icon: Icon(
                                        Icons.image,
                                        color: pictureCount <= 0
                                            ? Colors.grey
                                            : Colors.teal.shade500,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: videoCount <= 0
                                          ? null
                                          : () => fetchVideoViewData(
                                                      context,
                                                      ref,
                                                      sale.saleId,
                                                      sale.userPhoneNumber)
                                                  .then((_) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoListPage(
                                                    saleId: sale.saleId,
                                                  ),
                                                ));
                                              }),
                                      icon: Icon(
                                        Icons.video_library,
                                        color: videoCount <= 0
                                            ? Colors.grey
                                            : Colors.teal.shade500,
                                      ),
                                    ),
                                  ],
                                ),

                                // Add group
                                Row(
                                  children: [
                                    const RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        'Add: ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: pictureCount >= kMaxPicture
                                          ? null
                                          : () {
                                              // Action for the pictures button
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PictureAddPage(
                                                    saleId: sale.saleId,
                                                    phoneNumber:
                                                        sale.userPhoneNumber,
                                                    seedPicCount: pictureCount,
                                                  ),
                                                ),
                                              );
                                            },
                                      icon: Icon(
                                        Icons.image,
                                        color: pictureCount >= kMaxPicture
                                            ? Colors.grey
                                            : Colors.teal.shade500,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: videoCount >= kMaxVideo
                                          ? null
                                          : () {
                                              // Action for the videos button
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoAddPage(
                                                    saleId: sale.saleId,
                                                    phoneNumber:
                                                        sale.userPhoneNumber,
                                                    seedVideoCount: videoCount,
                                                  ),
                                                ),
                                              );
                                            },
                                      icon: Icon(
                                        Icons.video_library,
                                        color: sale.seedVideoCount >= kMaxVideo
                                            ? Colors.grey
                                            : Colors.teal.shade500,
                                      ),
                                    ),
                                    // Delete icon
                                    // IconButton(
                                    //   onPressed: () {
                                    //     // Action for the delete button
                                    //   },
                                    //   icon: const Icon(
                                    //     Icons.delete, // Delete icon
                                    //     color: Colors
                                    //         .grey, // Red color for delete icon
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        // onTap: () {
                        //   // Handle onTap action if needed
                        // },
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No Records Found'),
                );
        },
      ),
    );
  }

  Widget _buildSeedSaleCard(SeedSaleViewModel sale) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: ListTile(
        title: Text('Sale ID: ${sale.saleId}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fish: ${sale.fishName}'),
            Text('Fish: ${sale.userPhoneNumber}'),
            Text(
                'Quantity: ${sale.fishQuantity}, Rate: Rs ${sale.rate} / ${sale.qtyUom}'),
            Text(
                'Netting Date: ${DateFormat('dd MMM yyyy').format(sale.nettingDate)}'),
            Text(
                'Selling Date: ${DateFormat('dd MMM yyyy').format(sale.sellingDate)}'),
            Text('Remarks: ${sale.remarks}'),
            // Add any other details you want to display
          ],
        ),
        onTap: () {
          // Handle onTap action if needed
        },
      ),
    );
  }
}
