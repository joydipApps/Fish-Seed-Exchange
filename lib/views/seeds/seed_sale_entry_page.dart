import '../../models/fish-category/fish_category_model.dart';
import '../../providers/fish_category/fish_category_provider.dart';
import '../../views/seeds/seed_sale_entry_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import '../../models/fish-list/fish_list_model.dart';
import '../../models/location-list/location_list_model.dart';
import '../../models/seed_sale/seed_sale_add_model.dart';
import '../../providers/fish-list/fish_list_provider.dart';
import '../../providers/local_storage/phone_number_provider.dart';
import '../../providers/location-list/location_list_provider.dart';
import '../../providers/location/gps_location_provider.dart';
import '../../utils/show_snack_dialog.dart';
import '../../routes/app_route_constants.dart';
import '../appbar/common_app_bar.dart';
import '../fish-list/category_drop_down.dart';
import '../fish-list/fish_drop_down.dart';

class SeedSaleEntryPage extends ConsumerStatefulWidget {
  const SeedSaleEntryPage({super.key});

  @override
  ConsumerState<SeedSaleEntryPage> createState() => _SeedSaleEntryPageState();
}

class _SeedSaleEntryPageState extends ConsumerState<SeedSaleEntryPage> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _userPhNoController = TextEditingController();
  final TextEditingController _fishNameController = TextEditingController();
  final TextEditingController _fishQuantityController = TextEditingController();
  final TextEditingController _qtyUomController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  DateTime _sellingDate = DateTime.now();
  DateTime _nettingDate = DateTime.now();

  final TextEditingController _remarksController = TextEditingController();
  String _selectedUom = 'Kg';
  String _selectedFish = '';
  String _selectedCategory = '';
  bool isSaving = false;

  @override
  void dispose() {
    // Clear text field controllers
    _fishNameController.dispose();
    _fishQuantityController.dispose();
    _rateController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // checkAndNavigateToLocation();
    getCategoryAndFish();
  }

  void getCategoryAndFish() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<FishCategoryModel> categoryList =
          ref.read(fishCategoryModelProvider);
      final List<FishListModel> fishList = ref.read(fishListModelProvider);

      // Set default values if the lists are not empty
      if (categoryList.isNotEmpty) {
        setState(() {
          _selectedCategory = categoryList[0].categoryName;
        });
      }

      if (fishList.isNotEmpty) {
        setState(() {
          _selectedFish = fishList[0].fishName;
        });
      }
    });
  }

  // void checkAndNavigateToLocation() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final List<LocationListModel> locationList =
  //         ref.read(locationListModelProvider);
  //     if (locationList.isEmpty) {
  //       showSnackDialog(context, 9, 'Enter Location First');
  //       GoRouter.of(context)
  //           .pushNamed(AppRouteConstants.locationAddPageRouteName);
  //     }
  //   });
  // }

  bool areAllFieldsValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final List<FishCategoryModel> categoryList =
        ref.watch(fishCategoryModelProvider);
    final List<String> categoryNames =
        categoryList.map((category) => category.categoryName).toList();

    final List<FishListModel> fishList = ref.watch(fishListModelProvider);
    final List<String> fishNames =
        fishList.map((fish) => fish.fishName).toList();

    final String userPhoneNo = ref.read(phoneNoProvider);

    // Read GPS location from provider
    final Position? position = ref.read(gpsLocationProvider);
    final LocationListModel activeLocation = ref.watch(activeLocationProvider);
    final String activeLocationName = activeLocation.locationName;
    final String activeLocationId = activeLocation.locationId;

    // Extract latitude and longitude from position, handling null case
    final double latitude = position?.latitude ?? 0.0;
    final double longitude = position?.longitude ?? 0.0;

    // GoRouter _goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: commonAppBar(context, 'Seed Sale Entry', isIconBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'GPS Location : $latitude , $longitude',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Default Location : $activeLocationName',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                CategoryDropdown(
                  categoryNames: categoryNames,
                  selectedValue: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue ?? '';
                    });
                  },
                ),
                FishDropdown(
                  fishNames: fishNames,
                  selectedValue: _selectedFish,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFish = newValue ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: _fishQuantityController,
                  decoration: const InputDecoration(labelText: 'Fish Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter fish quantity' : null,
                  textCapitalization: TextCapitalization.words,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedUom,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUom =
                          newValue ?? 'Kg'; // Ensure a default value is set
                      _qtyUomController.text = _selectedUom;
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: 'Unit of Measurement'),
                  items: ['Kg', 'Pcs']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  controller: _rateController,
                  decoration: const InputDecoration(labelText: 'Rate'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter rate' : null,
                ),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _nettingDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _nettingDate = value;
                        });
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration:
                        const InputDecoration(labelText: 'Netting Date'),
                    child: Text('${_nettingDate.toLocal()}'.split(' ')[0]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _sellingDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          _sellingDate = value;
                        });
                      }
                    });
                  },
                  child: InputDecorator(
                    decoration:
                        const InputDecoration(labelText: 'Selling Date'),
                    child: Text('${_sellingDate.toLocal()}'.split(' ')[0]),
                  ),
                ),
                TextFormField(
                  controller: _remarksController,
                  decoration: const InputDecoration(labelText: 'Remarks'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter remarks' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final seedSale = SeedSaleAddModel(
                          saleId: "",
                          userPhoneNumber: userPhoneNo,
                          categoryName: _selectedCategory,
                          fishName: _selectedFish,
                          fishQuantity:
                              int.tryParse(_fishQuantityController.text) ?? 0,
                          sellingDate: _sellingDate,
                          nettingDate: _nettingDate,
                          rate: double.tryParse(_rateController.text) ?? 0.0,
                          qtyUom: _selectedUom,
                          remarks: _remarksController.text,
                          locationId: activeLocationId,
                          locationLat: latitude ?? 0.0,
                          locationLon: longitude ?? 0.0);

                      debugPrint('seed Page : Saving: $seedSale');
                      debugPrint(
                          'seed Page : Number: ${seedSale.userPhoneNumber}, Fish Name: ${seedSale.fishName}, Fish Quantity: ${seedSale.fishQuantity}, Selling Date: ${seedSale.sellingDate}, Netting Date: ${seedSale.nettingDate}, Rate: ${seedSale.rate}, Rate UOM: ${seedSale.qtyUom}, Remarks: ${seedSale.remarks}');

                      await seedSaleAddData(
                        context: context,
                        ref: ref,
                        seedSale: seedSale,
                      );

                      // Clear the text fields after saving
                      _fishQuantityController.clear();
                      _rateController.clear();
                      _remarksController.clear();

                      // Optionally, reset the dropdowns and dates to default values
                      setState(() {
                        _selectedCategory = '';
                        _selectedFish = '';
                        _selectedUom = 'Kg';
                        _sellingDate = DateTime.now();
                        _nettingDate = DateTime.now();
                      });
                    }
                  },
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
