import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/seed_sale/seed_sale_view_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class SeedSaleUpdateService {
  final String baseUrl = Urls.seedSaleUpdateEndPoint;

  Future<List<SeedSaleViewModel>?> updateSeedSaleDetails({
    required BuildContext context,
    required String saleId,
  }) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: json.encode({"sale_id": saleId}),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData != null && responseData['Details'] != null) {
          final List<dynamic> details = responseData['Details'];
          // final List<SeedSaleViewModel> seedSales =
          //     details.map(SeedSaleViewModel.fromJson).toList();
          //  update 8th June

          final List<SeedSaleViewModel> seedSales = details
              .map<SeedSaleViewModel>((item) =>
                  SeedSaleViewModel.fromJson(item as Map<String, dynamic>))
              .toList();

          return seedSales;
        } else {
          // showSnackDialog(context, 2, "No data found, try later.");
          return null;
        }
      } else {
        // showSnackDialog(context, 2, "No data found, try later.");
        return null;
      }
    } on SocketException {
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }
      return null;
    } on http.ClientException catch (e) {
      debugPrint('Network Error: $e');
      // showSnackDialog(context, 2, "Network Error.");
      return null;
    } on FormatException catch (e) {
      debugPrint('Format Error: $e');
      // showSnackDialog(context, 2, "Format Error.");
      return null;
    } catch (e) {
      debugPrint('Unknown Error: $e');
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error.");
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
