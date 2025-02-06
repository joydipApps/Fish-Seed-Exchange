import '../../views/register/show_restart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/local_storage/phoneno_presence_provider.dart';
import '../../utils/validation_function.dart';
import '../../utils/show_snack_dialog.dart';
import '../../utils/local_shared_Storage.dart';
import '../appbar/common_app_bar.dart';
import '../../providers/user/register_user_provider.dart';

class RegisterUser extends ConsumerStatefulWidget {
  const RegisterUser({super.key});

  @override
  ConsumerState<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends ConsumerState<RegisterUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late SharedPreferences prefs;
  String _selectedType = 'Buyer'; // Initialize with a default value
  bool isSaving = false;
  late bool phonePresence;
  bool areAllFieldsValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  void initState() {
    super.initState();
    localRegisteredProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Initialize SharedPreferences and retrieve stored values
  Future<void> localRegisteredProfile() async {
    final bool phonePresence = ref.read(phoneNoPresenceProvider);

    if (!phonePresence) {
      // If phoneNoPresenceProvider is false, set variables to empty strings
      setState(() {
        _phoneController.text = '';
        _nameController.text = '';
        _selectedType = '';
      });
      return;
    }

    final List<String> userData = await LocalSharedStorage.getUser();
    if (userData.length >= 3) {
      String storedName = userData[0]; // Accessing stored name
      String storedPhone = userData[1]; // Accessing stored phone number
      String storedUserType = userData[2]; // Accessing stored user type

      debugPrint(
          'C1,Name: $storedName, Phone: $storedPhone, Type: $storedUserType');

      if (storedPhone.isNotEmpty &&
          storedName.isNotEmpty &&
          storedUserType.isNotEmpty) {
        setState(() {
          _phoneController.text = storedPhone;
          _nameController.text = storedName;
          _selectedType = storedUserType;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'Register Yourself',
        isIconBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _phoneController,
                  readOnly: false,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      TextFieldValidation.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '10 Digit Number',
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      TextFieldValidation.validateGeneralText(value),
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Full Name',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedType.isNotEmpty
                      ? _selectedType
                      : null, // Ensure value is not empty or null
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType =
                          newValue ?? 'Farmer'; // Ensure a default value is set
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Work Role',
                    hintText: 'Select Work Role', // Add hint text here
                  ),
                  items: [
                    'Farmer - মাছ চাষী',
                    'Wholesaler - মাছের আরাতদার',
                    'Retailer - খুচরো মাছ বিক্রেতা ',
                    'Fisherman - জেলে',
                    'Agent -  এজেন্ট দালাল',
                    'Vehicle Owner - মাছের গাড়ির মালিক ',
                    'Net fishing - জাল পার্টি  মাছ ধরা',
                    // 'Fish water cart - জল দাওয়া মাছের গাড়ি',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value
                          .split(' - ')[0], // Store only the label in the value
                      child: Text(
                          value), // Display the full line with label and hint
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: isSaving
                      // || !areAllFieldsValid() // Disable the button if saving or fields are not valid
                      ? null
                      : () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // _formKey.currentState!.save();
                            // Form is valid, proceed with submission
                            final String name = _nameController.text;
                            final String phone = _phoneController.text;
                            final String type = _selectedType;

                            // Do something with the data (e.g., send it to a server)
                            debugPrint(
                                'C2,Phone: $phone,Name: $name, Phone: $phone, Type: $type');

                            // Store in local storage
                            await LocalSharedStorage.setUser(
                                name: name, phoneNo: phone, userType: type);

                            // send data through API.
                            final registerUserService =
                                ref.read(registerUserServiceProvider);

                            final apiResponse = await registerUserService
                                .registerUser(context, phone, name, type);

                            if (apiResponse != null) {
                              ref
                                  .read(registerUserSuccessProvider.notifier)
                                  .setRegisterUserSuccess(true);
                              ref
                                  .read(registerUserModelProvider.notifier)
                                  .addUser(apiResponse);

                              // change provider state
                              // todo add phoneno to provider
                              // final phoneNoPresence =
                              //     ref.read(phoneNoPresenceProvider.notifier);
                              // phoneNoPresence.setPresence(true);

                              if (context.mounted) {
                                showSnackDialog(
                                    context, 1, 'Record Saving Successful');
                              }
                            } else {
                              if (context.mounted) {
                                showSnackDialog(
                                    context, 2, 'Record Saving Failure');
                              }
                              // todo route page
                            }

                            // Clear text fields
                            _nameController.clear();
                            _phoneController.clear();

                            setState(() {
                              isSaving = false;
                            });

                            if (context.mounted) {
                              await showRestartDialog(context);
                            }
                          }
                        },
                  child: isSaving
                      ? const CircularProgressIndicator() // Show progress indicator when loading
                      : const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Later'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
