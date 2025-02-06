import '../../../providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/fish-category/fish_category_model.dart';
import '../../models/leads/leads_add_model.dart';
import '../../providers/fish_category/fish_category_provider.dart';
import '../fish-list/category_drop_down.dart';
import '../fish-list/fish_drop_down.dart';
import 'leads_add_function.dart';

class LeadsDialogPage extends ConsumerStatefulWidget {
  final String postType;
  final String refId;
  final String categoryName;
  final String fishName;
  final int fishQty;

  const LeadsDialogPage({
    super.key,
    required this.postType,
    required this.refId,
    required this.categoryName,
    required this.fishName,
    required this.fishQty,
  });

  @override
  LeadsDialogPageState createState() => LeadsDialogPageState();
}

class LeadsDialogPageState extends ConsumerState<LeadsDialogPage> {
  late String _userName;
  late String _userPhoneNumber;
  late String _selectedUom;
  late String _selectedCategory;
  late String _selectedFish;
  late String _remarks;
  late int _fishQty;

  @override
  void initState() {
    super.initState();
    _userName = ref.read(phoneNameProvider);
    _userPhoneNumber = ref.read(phoneNoProvider);
    _selectedUom = 'Kg'; // Initialize default value for UOM
    _selectedCategory = widget.categoryName;
    _selectedFish = widget.fishName;
    _fishQty = widget.fishQty;
    _remarks = '';
    debugPrint('initState: _selectedFish = $_selectedFish'); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    final List<FishCategoryModel> categoryList =
        ref.watch(fishCategoryModelProvider);
    final List<String> categoryNames =
        categoryList.map((category) => category.categoryName).toList();
    final fishList = ref.watch(fishListModelProvider);
    final fishNames = fishList.map((fish) => fish.fishName).toList();

    return AlertDialog(
      title: const Text('Interested:'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text('Keen to prebook fish seed for purchase.'),
            const SizedBox(height: 8),
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
                  _selectedFish = newValue ?? widget.fishName;
                  debugPrint(
                      'Dropdown onChanged: _selectedFish = $_selectedFish'); // Debug print
                });
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    initialValue: widget.fishQty.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _fishQty = int.tryParse(value) ?? _fishQty;
                        debugPrint(
                            'Quantity onChanged: _fishQty = $_fishQty'); // Debug print
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedUom,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUom = newValue ?? 'Kg';
                        debugPrint(
                            'UOM onChanged: _selectedUom = $_selectedUom'); // Debug print
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Unit of Measurement',
                    ),
                    items: ['Kg', 'Pcs'].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Remarks'),
              onChanged: (value) {
                setState(() {
                  _remarks = value;
                  debugPrint(
                      'Remarks onChanged: _remarks = $_remarks'); // Debug print
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            debugPrint(
                'Confirm pressed: _selectedFish = $_selectedFish'); // Debug print
            LeadsAddModel leadModel = LeadsAddModel(
              leadsId: "",
              userPhNo: _userPhoneNumber,
              userName: _userName,
              categoryName: _selectedCategory,
              fishName: _selectedFish,
              fishQty: _fishQty,
              qtyUom: _selectedUom,
              postDate: DateTime.now(),
              postType: widget.postType,
              refId: widget.refId,
              remarks: _remarks,
            );

            leadsAddFunction(context, ref, leadModel);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Save',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
