import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_route_constants.dart';
import '../../utils/constants.dart';
import '../../widgets/social_media.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: 64,
              child: DrawerHeader(
                // decoration: BoxDecoration(color: Colors.lightBlue.shade900),
                decoration: BoxDecoration(color: Colors.teal.shade300),
                // margin: EdgeInsets.all(0.0),
                // padding: EdgeInsets.all(0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          // Close the drawer when the close button is pressed
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: const Text(
                    'Register YourSelf',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.registerUserRouteName);
                  },
                ),

                const Divider(
                  color: Colors.grey, // Choose the color of the line
                  thickness: 1, // Choose the thickness of the line
                  indent: 20, // Optional: Add an indentation from the left
                  endIndent: 20, // Optional: Add an indentation from the right
                ),
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.black),
                  title: const Text(
                    'Share This App',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    shareContent(context, kShareBody, kShareSubject);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.black),
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                        AppRouteConstants.privacyPolicyPageRouteName);
                  },
                ),
                // ListTile(
                //   leading: const Icon(Icons.star, color: Colors.black),
                //   title: const Text(
                //     'Rate 5 Star',
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   onTap: () {
                //     GoRouter.of(context)
                //         .pushNamed(AppRouteConstants.rateAppPageRouteName);
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.update, color: Colors.black),
                //   title: const Text(
                //     'Check For App Update',
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   onTap: () {
                //     GoRouter.of(context)
                //         .pushNamed(AppRouteConstants.aboutUsPageRouteName);
                //   },
                // ),

                ListTile(
                  leading: const Icon(Icons.contact_mail, color: Colors.black),
                  title: const Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.contactUsPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.black),
                  title: const Text(
                    'About Us',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.aboutUsPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.library_books, color: Colors.black),
                  title: const Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                        AppRouteConstants.termsAndConditionsPageRouteName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.black),
                  title: const Text(
                    'Package Information',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(AppRouteConstants.packageInfoPageRouteName);
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.smartphone, color: Colors.black),
                //   title: Text(
                //     'Developed By',
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   onTap: () {
                //     GoRouter.of(context).pushNamed(
                //         AppRouteConstants.developerInfoPageRouteName);
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
