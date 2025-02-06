import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/location/location_view_model.dart';
import '../../providers/location/location_view_provider.dart';
import '../../widgets/launch_google_map.dart';

Future<void> showAddressFunction(
    BuildContext context, WidgetRef ref, String locationId) async {
  // Debug print 1: Watching locationViewModelProvider
  debugPrint('Debug print 1: Watching locationViewModelProvider');
  final List<LocationViewModel> locations =
      ref.watch(locationViewModelProvider);

  // Find the location with the matching locationId
  final location = locations.firstWhere(
    (location) => location.locationId == locationId,
    // orElse: () => null,
  );

  // Debug print 2: Showing address dialog
  debugPrint('Debug print 2: Showing address dialog');
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.teal.shade50,
        shadowColor: Colors.red,
        title: const Text(
          'Address :',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Location ID: ${location.locationId}'),
              Text('Location Name: ${location.locationName}'),
              Text('Location Type: ${location.locationType}'),
              Text('Village: ${location.village}'),
              Text('Post Office: ${location.postOffice}'),
              Text('District: ${location.district}'),
              Text('Police Station: ${location.policeStation}'),
              Text('Panchayat: ${location.panchayat}'),
              Text('Pincode: ${location.pinCode}'),
              Text('Mouja: ${location.mouja}'),
              Text('State: ${location.state}'),
            ],
          ),
        ),
        actions: <Widget>[
          Column(
            children: [
              // todo parked for next version.
              // IconButton(
              //   icon: const FaIcon(
              //     FontAwesomeIcons.mapLocation,
              //     size: 20,
              //   ),
              //   color: location.lat > 0 && location.lon > 0
              //       ? Colors.teal.shade500
              //       : Colors.grey,
              //   onPressed: () {
              //     location.lat > 0 && location.lon > 0
              //         ? launchGoogleMaps(
              //             context: context,
              //             latitude: location.lat,
              //             longitude: location.lon,
              //           )
              //         : null;
              //   },
              // ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10.0,
                  shadowColor: Colors.red,
                  backgroundColor: Colors.teal.shade100, // Set the button color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.teal.shade800, // Set the icon color
                    ),
                    const SizedBox(
                        width: 5), // Adjust the spacing between icon and text
                    Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal.shade800, // Set the text color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
