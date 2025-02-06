import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newfish/utils/constants.dart';
import '../../models/location/location_add_model.dart';
import '../../providers/imagery/media/picture_count_provider.dart';
import '../../providers/local_storage/phone_number_provider.dart';
import '../../providers/location-list/location_list_provider.dart';
import '../../providers/location/gps_location_provider.dart';
import '../../utils/show_snack_dialog.dart';
import '../../utils/validation_function.dart';
import '../appbar/common_app_bar.dart';
import 'location_add_function.dart';
import '../../providers/pin-code/pin_code_data_provider.dart';

class LocationSavePage extends ConsumerStatefulWidget {
  const LocationSavePage({super.key});

  @override
  LocationSavePageState createState() => LocationSavePageState();
}

class LocationSavePageState extends ConsumerState<LocationSavePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _locationTypeController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _policeStationController =
      TextEditingController();
  final TextEditingController _panchyatController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _moujaController = TextEditingController();

  String _selectedType = 'Pond';
  String? _selectedPostOffice;
  String? _selectedDistrict;
  List<String> _postOfficeList = [];
  List<String> _districtList = [];

  @override
  void dispose() {
    _locationNameController.dispose();
    _locationTypeController.dispose();
    _villageController.dispose();
    _policeStationController.dispose();
    _panchyatController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    _moujaController.dispose();
    _selectedDistrict = '';
    _selectedDistrict = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNo = ref.read(phoneNoProvider);
    final pinCodeDataProvider = ref.read(pinCodeDataServiceProvider);
    final Position? position = ref.read(gpsLocationProvider);
    final int locationCount = ref.read(locationCountProvider);
    final latitude = position?.latitude;
    final longitude = position?.longitude;

    return Scaffold(
      appBar: commonAppBar(context, 'Add Location', isIconBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'GPS Location : $latitude , $longitude',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextFormField(
                controller: _locationNameController,
                decoration: const InputDecoration(labelText: 'Location Name'),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              DropdownButtonFormField<String>(
                value: _selectedType.isNotEmpty ? _selectedType : null,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue ?? 'Pond';
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Location Type',
                  hintText: 'Select Location',
                ),
                items: [
                  'Pond - পুকুর',
                  'Shop - দোকান',
                  'Market - বাজার',
                  'Office - দপ্তর',
                  'Home -  বাড়ি',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.split(' - ')[0],
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _villageController,
                decoration: const InputDecoration(labelText: 'Village'),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              TextFormField(
                controller: _policeStationController,
                decoration: const InputDecoration(labelText: 'Police Station'),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              TextFormField(
                controller: _panchyatController,
                decoration: const InputDecoration(labelText: 'Panchyat'),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              TextFormField(
                controller: _moujaController,
                decoration: const InputDecoration(labelText: 'Mouja'),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              TextFormField(
                controller: _pinCodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Pin Code'),
                validator: (value) =>
                    TextFieldValidation.validatePinCode(value),
                onChanged: (value) async {
                  if (value.length >= 6) {
                    final List<Map<String, dynamic>>? data =
                        await pinCodeDataProvider.getData(context, value);
                    if (data != null) {
                      setState(() {
                        _postOfficeList = data
                            .map((e) => e['Name'] as String)
                            .toSet()
                            .toList();
                        _districtList = data
                            .map((e) => e['District'] as String)
                            .toSet()
                            .toList();
                        _stateController.text =
                            data.isNotEmpty ? data[0]['State'] : '';
                        // Reset the dropdown
                        _selectedPostOffice = _postOfficeList.isNotEmpty
                            ? _postOfficeList[0]
                            : null;
                        _selectedDistrict =
                            _districtList.isNotEmpty ? _districtList[0] : null;
                      });
                    }
                  }
                },
              ),
              // Dropdown for Post Offices
              DropdownButtonFormField<String>(
                value: _selectedPostOffice,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPostOffice = newValue;
                  });
                },
                decoration: const InputDecoration(labelText: 'Post Office'),
                items: _postOfficeList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              // Dropdown for Districts
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
                decoration: const InputDecoration(labelText: 'District'),
                items:
                    _districtList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) =>
                    TextFieldValidation.validateGeneralText(value),
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'State'),
                enabled: false,
                // validator: (value) =>
                //     TextFieldValidation.validateGeneralText(value),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final locationSaveModel = LocationAddModel(
                      locationId: "",
                      userPhoneNo: phoneNo,
                      locationName: _locationNameController.text,
                      locationType: _selectedType,
                      village: _villageController.text,
                      postOffice: _selectedPostOffice ?? '',
                      district: _selectedDistrict ?? '',
                      policeStation: _policeStationController.text,
                      panchayat: _panchyatController.text,
                      mouja: _moujaController.text,
                      state: _stateController.text,
                      pinCode: _pinCodeController.text,
                      lat: latitude ?? 0.0,
                      lon: longitude ?? 0.0,
                      isActive: locationCount == 0,
                    );

                    locationAddData(context, ref, locationSaveModel);
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
