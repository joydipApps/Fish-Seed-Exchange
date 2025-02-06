import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_route_constants.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final goRouter = GoRouter.of(context);
      return AlertDialog(
        backgroundColor: Colors.teal.shade50,
        shadowColor: Colors.red,
        title: const Text(
          'Exit :',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to exit?'),
        actions: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    shadowColor: Colors.yellowAccent,
                    backgroundColor:
                        Colors.teal.shade50, // Set the button color
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.green.shade700, // Set the icon color
                      ),
                      const SizedBox(
                          width: 5), // Adjust the spacing between icon and text
                      Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade700, // Set the text color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    while (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }

                    //   Navigator.of(context).pop();
                    goRouter.pushNamed(AppRouteConstants.welcomePageRouteName);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    shadowColor: Colors.yellowAccent,
                    backgroundColor:
                        Colors.teal.shade50, // Set the button color
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.stop,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Exit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
