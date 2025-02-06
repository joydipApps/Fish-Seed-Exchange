import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'themes/custom_app_theme.dart';
import 'routes/app_route_config.dart';
import 'package:in_app_update/in_app_update.dart';
// ignore: unused_import
import 'providers/all_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo appUpdateInfo = await InAppUpdate.checkForUpdate();

      if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      } else if (appUpdateInfo.updateAvailability ==
          UpdateAvailability.updateNotAvailable) {
        debugPrint(
            'No update available at the moment. Your app is up to date.');
      } else {
        debugPrint(
            'Unexpected update availability status: ${appUpdateInfo.updateAvailability}');
      }
    } catch (e) {
      debugPrint('Error checking for update: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Fish Seed Exchange',
      routerConfig: MyAppRouteConfig().router,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: CustomAppTheme.themeData.colorScheme,
        textTheme: CustomAppTheme.themeData.textTheme,
        appBarTheme: CustomAppTheme.themeData.appBarTheme,
        tabBarTheme: CustomAppTheme.themeData.tabBarTheme,
        cardTheme: CustomAppTheme.themeData.cardTheme,
        bottomNavigationBarTheme:
            CustomAppTheme.themeData.bottomNavigationBarTheme,
        drawerTheme: CustomAppTheme.themeData.drawerTheme,
        // Override specific properties from ThemeData.light
        // Example: appBarTheme: AppBarTheme(elevation: 0),
      ),
    );
  }
}

// PondTime - The Fishing Slot Booking App
