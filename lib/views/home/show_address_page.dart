import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/location/location_view_model.dart';
import '../../providers/location/location_view_provider.dart';
import '../../widgets/launch_google_map.dart';

class ShowAddressPage extends ConsumerStatefulWidget {
  final String locationId;

  const ShowAddressPage({super.key, required this.locationId});

  @override
  _ShowAddressPageState createState() => _ShowAddressPageState();
}

class _ShowAddressPageState extends ConsumerState<ShowAddressPage> {
  @override
  Widget build(BuildContext context) {
    final List<LocationViewModel> locations =
        ref.read(locationViewModelProvider);
    final location = locations.firstWhere(
      (location) => location.locationId == widget.locationId,
    );

    return AlertDialog(
      backgroundColor: Colors.teal.shade50,
      shadowColor: Colors.red,
      title: const Text(
        'Address:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.mapLocation,
                size: 20,
              ),
              color: location.lat > 0 && location.lon > 0
                  ? Colors.teal.shade500
                  : Colors.grey,
              onPressed: () {
                location.lat > 0 && location.lon > 0
                    ? launchGoogleMaps(
                        context: context,
                        latitude: location.lat,
                        longitude: location.lon,
                      )
                    : null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
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
  }
}
