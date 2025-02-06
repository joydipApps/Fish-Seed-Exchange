import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/app_route_constants.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToWelcomeScreen(context);
    });
  }

  void _navigateToWelcomeScreen(context) {
    GoRouter goRouter = GoRouter.of(context);
    Future.delayed(const Duration(seconds: 2), () {
      try {
        goRouter.goNamed(AppRouteConstants.welcomePageRouteName);
      } catch (e) {
        debugPrint("Error navigating to WelcomeScreen: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.fishFins,
                  color: Colors.black,
                  size: 100,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Fish Seed Exchange',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
