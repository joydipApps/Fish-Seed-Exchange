import 'package:flutter/material.dart';

class DropdownCheckboxField extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;

  const DropdownCheckboxField({super.key, 
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  });

  @override
  _DropdownCheckboxFieldState createState() => _DropdownCheckboxFieldState();
}

class _DropdownCheckboxFieldState extends State<DropdownCheckboxField> {
  late bool _isDropdownOpen;

  @override
  void initState() {
    super.initState();
    _isDropdownOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Fish Names',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _isDropdownOpen = !_isDropdownOpen;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select Fish Names'),
                Icon(_isDropdownOpen
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (_isDropdownOpen)
          Column(
            children: widget.options.map((fish) {
              bool isSelected = widget.selectedOptions.contains(fish);
              return CheckboxListTile(
                title: Text(fish),
                value: isSelected,
                onChanged: (newValue) {
                  setState(() {
                    if (newValue != null) {
                      if (newValue) {
                        widget.selectedOptions.add(fish);
                      } else {
                        widget.selectedOptions.remove(fish);
                      }
                      widget.onChanged(widget.selectedOptions);
                    }
                  });
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}
