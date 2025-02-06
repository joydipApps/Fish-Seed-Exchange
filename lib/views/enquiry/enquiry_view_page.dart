import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enquiry/enquiry_view_model.dart';
import '../../providers/enquiry/enquiry_view_provider.dart';
import '../../providers/local_storage/phone_number_provider.dart';
import '../../providers/local_storage/phoneno_presence_provider.dart';
import '../../utils/check_count_show_snackbar.dart';
import '../../utils/show_snack_dialog.dart';
import '../../widgets/launch_phone_dialer.dart';
import '../../widgets/share_image.dart';
import '../appbar/common_app_bar.dart';
import '../leads/leads_dialog_page.dart';

class EnquiryViewPage extends ConsumerStatefulWidget {
  const EnquiryViewPage({super.key});

  @override
  EnquiryViewPageState createState() => EnquiryViewPageState();
}

class EnquiryViewPageState extends ConsumerState<EnquiryViewPage> {
  late String _phoneNo1;
  final List<GlobalKey> _globalKeys = [];
  late bool _isPhoneNoPresent;

  @override
  void initState() {
    super.initState();
    _phoneNo1 = ref.read(phoneNoProvider);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      checkCountAndShowSnackBar(context, ref, enquiryCountProvider, 'Enquiry');
    });
  }

  @override
  Widget build(BuildContext context) {
    _isPhoneNoPresent = ref.watch(phoneNoPresenceProvider);
    final List<EnquiryViewModel> enquiryList =
        ref.watch(enquiryViewModelProvider);

    debugPrint('Phone No Present $_isPhoneNoPresent');
    debugPrint('Phone No Present $_isPhoneNoPresent');

    return Scaffold(
      appBar: commonAppBar(
        context,
        'Fish Seed Enquiry',
        isIconBack: true,
      ),
      body: ListView.builder(
        itemCount: enquiryList.length,
        itemBuilder: (context, index) {
          final enquiryData = enquiryList[index];

          // Get username from the enquiry data
          final String phoneNo2 = enquiryData.userPhNo;
          // Check if the phone numbers match
          final bool isOwnPhone = _phoneNo1 == phoneNo2;

          final key = GlobalKey();
          _globalKeys.add(key);

          return RepaintBoundary(
            key: key,
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '# ${enquiryData.enquiryId} : ${enquiryData.userName} - ${enquiryData.userPhNo}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Text('Fish : ${enquiryData.fishName}'),
                    Text(
                        'Fish Type: ${enquiryData.categoryName} - ${enquiryData.fishName}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        'Quantity: ${enquiryData.fishQty} ${enquiryData.qtyUom}  Size: ${enquiryData.fishSize}'),
                    Text(
                      'Posted On: ${DateFormat.yMMMd().format(enquiryData.createdDate)}',
                    ),
                    Text(
                      'Required By: ${DateFormat.yMMMd().format(enquiryData.requiredDate)}',
                    ),
                    Text('Remarks: ${enquiryData.remarks}'),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Text(enquiryData.userType),
                        const Spacer(),
                        IconButton(
                          onPressed: _isPhoneNoPresent
                              ? () {
                                  // Navigate to LeadsDialogPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LeadsDialogPage(
                                        //   userPhNo: enquiryData.userPhNo,
                                        //   userName: enquiryData.userName,
                                        postType: 'Enquiry',
                                        refId: enquiryData.enquiryId,
                                        categoryName: enquiryData.categoryName,
                                        fishName: enquiryData.fishName,
                                        fishQty: enquiryData.fishQty,
                                      ),
                                    ),
                                  );
                                }
                              : () {
                                  showSnackDialog(
                                      context, 9, "Register Yourself.");
                                },
                          icon: FaIcon(
                            FontAwesomeIcons.basketShopping,
                            color:
                                isOwnPhone ? Colors.grey : Colors.teal.shade500,
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          color:
                              isOwnPhone ? Colors.grey : Colors.teal.shade500,
                          onPressed: isOwnPhone
                              ? null
                              : () {
                                  launchPhoneDialer(
                                    context: context,
                                    phNo: enquiryData.userPhNo,
                                  );
                                },
                          icon: const FaIcon(
                            FontAwesomeIcons.phone,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () => _shareImageWithDelay(key),
                          icon: Icon(Icons.share, color: Colors.teal.shade500),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _shareImageWithDelay(GlobalKey key) async {
    // Add a sufficient delay to ensure the widget is fully rendered
    await Future.delayed(const Duration(milliseconds: 300));
    await shareImage(key);
  }
}
