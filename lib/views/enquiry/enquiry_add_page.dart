import '../../models/fish-category/fish_category_model.dart';
import '../../providers/all_providers.dart';
import '../../providers/fish_category/fish_category_provider.dart';
import '../../views/enquiry/enquiry_add_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/enquiry/enquiry_add_model.dart';
import '../../models/fish-list/fish_list_model.dart';
// Import necessary providers
import '../../utils/validation_function.dart';
import '../appbar/common_app_bar.dart';
import '../fish-list/category_drop_down.dart';
import '../fish-list/fish_drop_down.dart';

class EnquiryAddPage extends ConsumerStatefulWidget {
  const EnquiryAddPage({super.key});

  @override
  ConsumerState<EnquiryAddPage> createState() => _EnquiryAddPageState();
}

class _EnquiryAddPageState extends ConsumerState<EnquiryAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _fishNameController = TextEditingController();
  final TextEditingController _fishQtyController = TextEditingController();
  final TextEditingController _qtyUomController = TextEditingController();

  final TextEditingController _fishSizeController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  late DateTime _requiredDate;
  String _selectedQtyUom = 'Kg';
  String _selectedCategory = '';
  String _selectedFish = '';

  // List<String> _selectedFishNames = [];

  @override
  void initState() {
    super.initState();
    _requiredDate = DateTime.now();
    _selectedQtyUom = 'Kg'; // Initialize default value for UOM
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<FishCategoryModel> categoryList =
          ref.read(fishCategoryModelProvider);
      final List<FishListModel> fishList = ref.read(fishListModelProvider);

      // Set default values if the lists are not empty
      if (categoryList.isNotEmpty) {
        setState(() {
          _selectedCategory = categoryList[0].categoryName;
          debugPrint('Selected Category: $_selectedCategory'); // Debug print
        });
      }

      if (fishList.isNotEmpty) {
        setState(() {
          _selectedFish = fishList[0].fishName;
          debugPrint('Selected Fish: $_selectedFish'); // Debug print
        });
      }
    });
  }

  @override
  void dispose() {
    // Clear text fields
    _categoryNameController.dispose();
    _fishNameController.dispose();
    _fishQtyController.dispose();
    _fishSizeController.dispose();
    _qtyUomController.dispose();
    _remarksController.dispose();
    super.dispose();
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
    final userPhNo = ref.read(phoneNoProvider);

    return Scaffold(
      appBar: commonAppBar(context, 'Add Enquiry', isIconBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  controller: _fishQtyController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                  decoration: const InputDecoration(
                    labelText: 'Fish Quantity',
                    hintText: 'Enter fish quantity',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedQtyUom,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedQtyUom =
                          newValue ?? 'Kg'; // Ensure a default value is set
                      _qtyUomController.text = _selectedQtyUom;
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
                  controller: _fishSizeController,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                  decoration: const InputDecoration(
                    labelText: 'Fish Size',
                    hintText: 'Enter fish size',
                  ),
                ),
                TextFormField(
                  controller: _remarksController,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                  decoration: const InputDecoration(
                    labelText: 'Remarks',
                    hintText: 'Enter remarks',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Form is valid, proceed with submission
                      final EnquiryAddModel enquiryData = EnquiryAddModel(
                        enquiryId: "",
                        userPhNo: userPhNo,
                        categoryName: _selectedCategory,
                        fishName: _selectedFish,
                        fishQty: int.parse(_fishQtyController.text),
                        qtyUom: _fishSizeController.text,
                        fishSize: _fishSizeController.text,
                        requiredDate: _requiredDate,
                        remarks: _remarksController.text,
                        createdDate: DateTime.now(),
                      );

                      await enquiryAddData(
                        context: context,
                        ref: ref,
                        enquiryData: enquiryData,
                      );

                      setState(
                        () {
                          _requiredDate = DateTime.now();
                        },
                      );
                      _fishNameController.clear();
                      _fishQtyController.clear();
                      _fishSizeController.clear();
                      _qtyUomController.clear();
                      _remarksController.clear();
                    }
                  },
                  child: const Text('Add Enquiry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
