import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/seed_sale/seed_sale_add_model.dart';
import '../../routes/http_urls.dart';
import '../../utils/show_progress_dialog.dart';
import '../../utils/show_snack_dialog.dart';

class SeedSaleAddService {
  final String baseUrl = Urls.seedSaleDetailsSaveEndPoint;

  Future<SeedSaleAddModel?> saveSeedSaleDetails(
      BuildContext context, SeedSaleAddModel saleDetails) async {
    showProgressDialogSync(context); // Show loading indicator

    try {
      debugPrint('SeedSale: Attempting to post data to $baseUrl');
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode(
            saleDetails.toJson()), // Convert SeedSaleInsertModel to JSON
      );

      debugPrint('SeedSale: Response status code: ${response.statusCode}');
      debugPrint('SeedSale: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic>? responseData = json.decode(response.body);
        debugPrint('SeedSale: Response data: $responseData');

        if (responseData != null && responseData.containsKey('Details')) {
          final dynamic saleData = responseData['Details'];
          debugPrint('SeedSale: Sale data: $saleData');

          if (saleData != null && saleData is Map<String, dynamic>) {
            final seedSaleModel = SeedSaleAddModel.fromJson(saleData);
            debugPrint('SeedSale: Parsed seed sale model: $seedSaleModel');
            // displaySnackBar(context, 1, 'Record Saving Successful');

            return seedSaleModel;
          } else {
            debugPrint(
                'SeedSale: Error: Sale data is null or not a Map<String, dynamic>');
            //displaySnackBar(context, 2, "No data found, try later.");
            return null;
          }
        } else {
          debugPrint(
              'SeedSale:Error: Response body does not contain expected data structure');
          // displaySnackBar(context, 2, "No data found, try later.");
          return null;
        }
      } else {
        debugPrint('SeedSale: API Error: ${response.body}');
        // showSnackDialog(context, 2, "No data found, try later.");
        return null;
      }
    } on SocketException {
      debugPrint('SeedSale: Network Error: Please check your connection.');
      if (context.mounted) {
        showSnackDialog(context, 6, "Please check your connection.");
      }

      return null;
    } on http.ClientException catch (e) {
      debugPrint('SeedSale: Network Error: $e'); // Debug point 10
      // showSnackDialog(context, 2, "Network Error, try later.");
      return null;
    } on FormatException catch (e) {
      debugPrint('SeedSale: Format Error: $e'); // Debug point 11
      // showSnackDialog(context, 2, "Format Error, try later.");
      return null;
    } catch (e) {
      debugPrint('SeedSale: Unknown Error: $e');
      if (context.mounted) {
        showSnackDialog(context, 2, "Unknown Error, try later.");
      }
      return null;
    } finally {
      if (context.mounted) {
        Navigator.pop(context);
      }
      debugPrint('SeedSale: Dialog dismissed');
    }
  }
}
