import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newfish/utils/show_snack_dialog.dart';

// Function to check the count from a provider and show a snackbar if zero
void checkCountAndShowSnackBar<T>(
  BuildContext context,
  WidgetRef ref,
  ProviderBase<int> provider,
  String msg,
) {
  final count = ref.read(provider);

  if (count == 0) {
    // Show a SnackBar if the count is zero

    showSnackDialog(context, 4, 'Please Add $msg Data.');
  }
}
