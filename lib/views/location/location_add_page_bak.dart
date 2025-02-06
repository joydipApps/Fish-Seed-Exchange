// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../models/location/location_add_model.dart';
// import '../../providers/local_storage/phone_number_provider.dart';
// import '../../service/validation_function.dart';
// import '../appbar/common_app_bar.dart';
// import '../../widgets/get_gps_location.dart';
// import 'location_add_function.dart';
//
// class LocationSavePage extends ConsumerStatefulWidget {
//   const LocationSavePage({Key? key}) : super(key: key);
//
//   @override
//   _LocationSavePageState createState() => _LocationSavePageState();
// }
//
// class _LocationSavePageState extends ConsumerState<LocationSavePage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   // final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _locationNameController = TextEditingController();
//   final TextEditingController _locationTypeController = TextEditingController();
//   final TextEditingController _villageController = TextEditingController();
//   final TextEditingController _postOfficeController = TextEditingController();
//   final TextEditingController _districtController = TextEditingController();
//   final TextEditingController _policeStationController =
//   TextEditingController();
//   final TextEditingController _panchyatController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _pinCodeController = TextEditingController();
//   final TextEditingController _moujaController = TextEditingController();
//   double latitude = 0.0;
//   double longitude = 0.0;
//   String _selectedType = 'Pond';
//
//   void updateLocation(double newLatitude, double newLongitude) {
//     setState(() {
//       latitude = newLatitude;
//       longitude = newLongitude;
//     });
//     debugPrint('setState Latitude: $latitude, Longitude: $longitude');
//   }
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     debugPrint('Inside didChangeDDependencies');
//     getLocation();
//   }
//
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   setState(() {
//   //     _gpsLocationState = ref.read(gpsLocationProvider);
//   //     double? latitude = _gpsLocationState?.latitude;
//   //     double? longitude = _gpsLocationState?.longitude;
//   //   });
//   // }
//
//   void getLocation() async {
//     debugPrint('Inside get Location');
//     // Call getMyLocation function to fetch location
//     Position position = await getGpsLocation(context);
//     double latitude = position.latitude;
//     double longitude = position.longitude;
//     updateLocation(latitude, longitude);
//
//     // setState(() {
//     //   // Use the latitude, longitude, and timestamp from the Position object
//     //   double latitude = position.latitude;
//     //   double longitude = position.longitude;
//     //   debugPrint('setState Latitude: $latitude, Longitude: $longitude');
//     // });
//   }
//
//   @override
//   void dispose() {
//     _locationNameController.dispose();
//     _locationTypeController.dispose();
//     _villageController.dispose();
//     _postOfficeController.dispose();
//     _districtController.dispose();
//     _policeStationController.dispose();
//     _panchyatController.dispose();
//     _stateController.dispose();
//     _pinCodeController.dispose();
//     _moujaController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _phoneNo = ref.read(phoneNoProvider);
//
//     return Scaffold(
//       appBar: commonAppBar(context, 'Add Location', isIconBack: true),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 'GPS Location : $latitude , $longitude',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//               TextFormField(
//                 controller: _locationNameController,
//                 decoration: InputDecoration(labelText: 'Location Name'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               DropdownButtonFormField<String>(
//                 value: _selectedType.isNotEmpty
//                     ? _selectedType
//                     : null, // Ensure value is not empty or null
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedType =
//                         newValue ?? 'Pond'; // Ensure a default value is set
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Location Type',
//                   hintText: 'Select Location', // Add hint text here
//                 ),
//                 items: [
//                   'Pond - পুকুর',
//                   'Shop - দোকান',
//                   'Market - বাজার',
//                   'Office - দপ্তর',
//                   'Home -  বাড়ি',
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value
//                         .split(' - ')[0], // Store only the label in the value
//                     child: Text(
//                         value), // Display the full line with label and hint
//                   );
//                 }).toList(),
//               ),
//               TextFormField(
//                 controller: _villageController,
//                 decoration: InputDecoration(labelText: 'Village'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               TextFormField(
//                 controller: _postOfficeController,
//                 decoration: InputDecoration(labelText: 'Post Office'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//
//               TextFormField(
//                 controller: _policeStationController,
//                 decoration: InputDecoration(labelText: 'Police Station'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               TextFormField(
//                 controller: _panchyatController,
//                 decoration: InputDecoration(labelText: 'Panchyat'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               TextFormField(
//                 controller: _moujaController,
//                 decoration: InputDecoration(labelText: 'Mouja'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               TextFormField(
//                 controller: _pinCodeController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Pin Code'),
//                 validator: (value) =>
//                     TextFieldValidation.validatePinCode(value),
//               ),
//               TextFormField(
//                 controller: _districtController,
//                 decoration: InputDecoration(labelText: 'District'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               TextFormField(
//                 controller: _stateController,
//                 decoration: InputDecoration(labelText: 'State'),
//                 validator: (value) =>
//                     TextFieldValidation.validateGeneralText(value),
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Form is valid, save data
//                     final userPhoneNo = _phoneNo;
//                     final locationName = _locationNameController.text;
//                     final locationType = _selectedType;
//                     final village = _villageController.text;
//                     final postOffice = _postOfficeController.text;
//                     final district = _districtController.text;
//                     final policeStation = _policeStationController.text;
//                     final panchyat = _panchyatController.text;
//                     final state = _stateController.text;
//                     final pinCode = _pinCodeController.text;
//                     final lat = latitude;
//                     final lon = longitude;
//                     final mouja = _moujaController.text;
//
//                     // Create LocationSaveModel object
//                     final locationSaveModel = LocationAddModel(
//                       userPhoneNo: userPhoneNo, // Fill with appropriate value
//                       locationName: locationName,
//                       locationType: locationType,
//                       village: village,
//                       postOffice: postOffice,
//                       district: district,
//                       policeStation: policeStation,
//                       panchayat: panchyat,
//                       state: state,
//                       pinCode: pinCode,
//                       lat: lat,
//                       lon: lon,
//                       mouja: mouja,
//                     );
//
//                     locationAddData(context, ref, locationSaveModel);
//
//                     // Save or send locationSaveModel object
//                     // Example: Provider.of<LocationSaveService>(context, listen: false).saveLocation(locationSaveModel);
//
//                     // Clear text fields
//                     _locationNameController.clear();
//                     _locationTypeController.clear();
//                     _villageController.clear();
//                     _postOfficeController.clear();
//                     _districtController.clear();
//                     _policeStationController.clear();
//                     _panchyatController.clear();
//                     _stateController.clear();
//                     _pinCodeController.clear();
//                     _moujaController.clear();
//                   }
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
