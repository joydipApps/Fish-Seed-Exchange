import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../models/leads/leads_view_model.dart';
import '../../providers/leads/leads_view_provider.dart';
import '../../utils/check_count_show_snackbar.dart';
import '../../widgets/launch_phone_dialer.dart';
import '../appbar/common_app_bar.dart';

class LeadsViewPage extends ConsumerStatefulWidget {
  const LeadsViewPage({super.key});

  @override
  LeadsViewPageState createState() => LeadsViewPageState();
}

class LeadsViewPageState extends ConsumerState<LeadsViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      checkCountAndShowSnackBar(context, ref, leadsCountProvider, 'Leads');
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<LeadsViewModel> leadsList = ref.watch(leadsViewModelProvider);

    return Scaffold(
      appBar: commonAppBar(
        context,
        'Interested Leads',
        isIconBack: true,
      ),
      body: ListView.builder(
        itemCount: leadsList.length,
        itemBuilder: (context, index) {
          final leadData = leadsList[index];

          return Card(
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                '#: ${leadData.leadsId}, Date : ${DateFormat.yMMMd().format(leadData.postDate)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('From: ${leadData.userName} - ${leadData.userPhNo}'),
                  // Text('Fish: ${leadData.fishName}'),
                  Text(
                      'Fish Type: ${leadData.categoryName} - ${leadData.fishName}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Fish Quantity: ${leadData.fishQty} ${leadData.qtyUom}'),
                  Text('Remarks: ${leadData.remarks}'),
                  Text(
                      'Reference Post No : ${leadData.refId} : ${leadData.postType}'),
                ],
              ),
              trailing: IconButton(
                color: Colors.teal.shade500,
                icon: const FaIcon(
                  FontAwesomeIcons.phone,
                  size: 16,
                ),
                onPressed: () {
                  launchPhoneDialer(
                    context: context,
                    phNo: leadData.userPhNo,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
