import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/local_storage/phone_number_provider.dart';
import '../../routes/app_route_constants.dart';
import '../location-list/location_list_function.dart';

class HomePageBottomGuest extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const HomePageBottomGuest({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    GoRouter goRouter = GoRouter.of(context);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Enquiry',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.redAccent.shade700,
          ),
          label: 'Register',
          tooltip: "Name and Phone No",
        ),
      ],
    );
  }
}
