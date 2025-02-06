import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart'; // Ensure you have this package in your pubspec.yaml
import 'package:newfish/utils/constants.dart';
import '../../../models/imagery/picture/picture_add_model.dart';
import '../../../providers/imagery/media/picture_count_provider.dart';
import '../../../utils/show_snack_dialog.dart';
import '../../appbar/common_app_bar.dart';
import 'picture_add_function.dart';

class PictureAddPage extends ConsumerStatefulWidget {
  final String saleId;
  final String phoneNumber;
  final int seedPicCount;

  const PictureAddPage({
    super.key,
    required this.saleId,
    required this.phoneNumber,
    required this.seedPicCount,
  });

  @override
  PictureAddPageState createState() => PictureAddPageState();
}

class PictureAddPageState extends ConsumerState<PictureAddPage> {
  File? _selectedImage;
  String? _selectedRadio;
  String? base64Image;

  @override
  void initState() {
    super.initState();
    _selectedRadio = 'camera';
    // Set default radio selection to 'camera'
  }

  void _handleRadioChange(String? value) {
    setState(() {
      _selectedRadio = value;
    });
    debugPrint('PictureAddPage Radio value changed: $_selectedRadio');
  }

  Future<void> _onImageSelected(File image) async {
    try {
      debugPrint('PictureAddPage Image selected: ${image.path}');

      if (!await image.exists()) {
        debugPrint('PictureAddPage Selected image file does not exist');
        return;
      }

      List<int> imageBytes = await image.readAsBytes();
      debugPrint('PictureAddPage Image bytes length: ${imageBytes.length}');

      if (imageBytes.isEmpty) {
        debugPrint('PictureAddPage Image bytes are empty');
        return;
      }

      String encodedImage = base64Encode(imageBytes);
      debugPrint('PictureAddPage Base64-encoded image: $encodedImage');

      setState(() {
        base64Image = encodedImage;
        _selectedImage = image;
      });

      debugPrint('PictureAddPage base64Image updated');
      debugPrint(
          'PictureAddPage _selectedImage set with path: ${_selectedImage?.path}');
    } catch (e) {
      debugPrint('PictureAddPage Error during image selection: $e');
    }
  }

  void _exitIfMaxPictureLimit(int pictureCount, int kMaxPicture) {
    if (pictureCount == kMaxPicture) {
      if (context.mounted) {
        showSnackDialog(
            context, 9, "The maximum limit of $kMaxPicture reached.");
        Navigator.pop(context); // Pop the current screen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('PictureAddPage Building UI');
    debugPrint('PictureAddPage _selectedImage: $_selectedImage');
    debugPrint('PictureAddPage base64Image: $base64Image');
    final pictureCount = ref.watch(salePictureCounterProvider(widget.saleId));

    Widget imageInput = _selectedRadio == 'camera'
        ? ImageInputCamera(onImageSelected: _onImageSelected)
        : ImageInputGallery(onImageSelected: _onImageSelected);

    return Scaffold(
      appBar: commonAppBar(
        context,
        'Add Picture',
        isIconBack: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '#: ${widget.saleId}, Picture Count: $pictureCount / $kMaxPicture'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'camera',
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioChange,
                ),
                const Text('Camera'),
                Radio<String>(
                  value: 'gallery',
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioChange,
                ),
                const Text('Gallery'),
              ],
            ),
          ),
          imageInput,
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              ),
            ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  debugPrint('PictureAddPage Save button pressed');

                  try {
                    File? image = _selectedImage;
                    if (image == null) {
                      debugPrint('PictureAddPage No image selected');
                      return;
                    }

                    List<int> imageBytes = await image.readAsBytes();
                    if (imageBytes.isEmpty) {
                      debugPrint('PictureAddPage Image bytes are empty');
                      return;
                    }

                    String encodedImage = base64Encode(imageBytes);
                    debugPrint(
                        'PictureAddPage Base64-encoded image: $encodedImage');

                    final addPicture = PictureAddModel(
                      saleId: widget.saleId,
                      pictureId: '',
                      userPhNo: widget.phoneNumber,
                      pictureBase64: encodedImage,
                    );

                    pictureAddFunction(
                      context: context,
                      ref: ref,
                      addPicture: addPicture,
                    );
                    _exitIfMaxPictureLimit(pictureCount, kMaxPicture);
                  } catch (e) {
                    debugPrint('PictureAddPage Error saving picture: $e');
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageInputCamera extends StatelessWidget {
  final Function(File) onImageSelected;

  const ImageInputCamera({super.key, required this.onImageSelected});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      debugPrint('ImageInputCamera: Image selected: ${imageFile.path}');
      onImageSelected(imageFile);
    } else {
      debugPrint('ImageInputCamera: No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(context),
          child: const Text('Capture Image from Camera'),
        ),
      ],
    );
  }
}

class ImageInputGallery extends StatelessWidget {
  final Function(File) onImageSelected;

  const ImageInputGallery({super.key, required this.onImageSelected});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      debugPrint('ImageInputGallery: Image selected: ${imageFile.path}');
      onImageSelected(imageFile);
    } else {
      debugPrint('ImageInputGallery: No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(context),
          child: const Text('Select Image from Gallery'),
        ),
      ],
    );
  }
}
