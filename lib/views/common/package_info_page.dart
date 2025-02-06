// package_info_page.dart -checked
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../utils/show_snack_dialog.dart';
import '../appbar/common_app_bar.dart';

class DeviceInfoPage extends StatelessWidget {
  const DeviceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'Package Information',
        isIconBack: true,
      ),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            showSnackDialog(context, 3, 'Please try again : ${snapshot.error}');
          } else if (!snapshot.hasData) {
            showSnackDialog(context, 4, 'No data available');
          }

          final packageInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Name: ${packageInfo.appName}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                Text(
                  'Package Name: ${packageInfo.packageName}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                Text(
                  'Version: ${packageInfo.version}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                Text(
                  'Build Number: ${packageInfo.buildNumber}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                Text('Build Signature: ${packageInfo.buildSignature}',
                    style: const TextStyle(fontSize: 16.0)),
                const SizedBox(height: 10),
                Text(
                    'Installer Store: ${packageInfo.installerStore ?? 'Not Available'}',
                    style: const TextStyle(fontSize: 16.0)),
                const SizedBox(height: 10),
                const Text('Developed By : Joydip Shome',
                    style: TextStyle(fontSize: 16.0)),
              ],
            ),
          );
        },
      ),
    );
  }
}
