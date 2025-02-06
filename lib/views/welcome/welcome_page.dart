import 'dart:math';
import '../../providers/local_storage/phoneno_presence_provider.dart';
import '../../views/welcome/welcome_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_route_constants.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  final String baseImageName = 'assets/images/image';
  final int numberOfImages = 5;
  bool isPageScrolling = false;
  late String currentImage;

  @override
  void initState() {
    super.initState();
    // Initialize with a random image
    currentImage = getRandomImage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      welcomeFunctions(context, ref);
    });
  }

  String getRandomImage() {
    final random = Random();
    final randomIndex = random.nextInt(numberOfImages) + 1;
    debugPrint('random no $randomIndex');
    return '$baseImageName$randomIndex.jpg';
  }

  void changeImage() {
    setState(() {
      // Change to a new random image
      currentImage = getRandomImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhoneNoPresent = ref.watch(phoneNoPresenceProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    const double aspectRatio = 16 / 9;
    final double imageHeight = screenWidth / aspectRatio;
    GoRouter goRouter = GoRouter.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.7,
            child: Image.asset(
              'assets/welcome/welcome.jpg',
              fit: BoxFit.cover,
              width: screenWidth,
              height: imageHeight,
              colorBlendMode: BlendMode.hardLight,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30.0),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: changeImage,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.asset(
                            currentImage,
                            height: imageHeight,
                            width: screenWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Fish Seed Exchange',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Kolkata ( Naihati & Bankura)',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Text(
                        'Cast your net wider with our app for fish seed sellers and buyers - where every catch is a win!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 45.0),
                      ElevatedButton(
                        onPressed: () {
                          if (isPhoneNoPresent) {
                            goRouter.goNamed(
                              AppRouteConstants.homeMenuPageRouteName,
                            );
                          } else {
                            goRouter.goNamed(
                              AppRouteConstants.homeGuestPageRouteName,
                            );
                          }
                        },
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(10),
                          shadowColor: WidgetStateProperty.all(Colors.white54),
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            return Colors.blue.shade700;
                          }),
                        ),
                        child: const Text(
                          "Start Casting Net",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () async {
                          SystemNavigator.pop();
                        },
                        child: const Text(
                          'Stop Casting Net',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
