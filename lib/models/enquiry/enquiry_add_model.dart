import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnquiryAddModel {
  String enquiryId;
  String userPhNo;
  String categoryName;
  String fishName;
  int fishQty;
  String qtyUom;
  String fishSize;
  DateTime requiredDate;
  String remarks;
  DateTime createdDate;

  EnquiryAddModel({
    required this.enquiryId,
    required this.userPhNo,
    required this.categoryName,
    required this.fishName,
    required this.fishQty,
    required this.qtyUom,
    required this.fishSize,
    required this.requiredDate,
    required this.remarks,
    required this.createdDate,
  });

  factory EnquiryAddModel.fromJson(Map<String, dynamic> json) {
    return EnquiryAddModel(
      enquiryId: json["enquiry_id"] ?? "",
      userPhNo: json["user_phno"] ?? "",
      categoryName: json["cat_name"] ?? "",
      fishName: json["fish_name"] ?? "",
      fishQty: json["fish_qty"] ?? 0,
      qtyUom: json["qty_uom"] ?? '',
      fishSize: json["fish_size"] ?? "",
      requiredDate: DateTime.parse(json["required_date"] ?? ""),
      remarks: json["remarks"] ?? "",
      createdDate: DateTime.parse(json["created_date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "enquiry_id": enquiryId,
      "user_phno": userPhNo,
      "cat_name": categoryName,
      "fish_name": fishName,
      "fish_qty": fishQty,
      "qty_uom": qtyUom,
      "fish_size": fishSize,
      "required_date": requiredDate.toIso8601String(),
      "remarks": remarks,
      "created_date": createdDate.toIso8601String(),
    };
  }
}

class EnquiryAddModelNotifier extends StateNotifier<List<EnquiryAddModel>> {
  EnquiryAddModelNotifier() : super([]); // Initialize with an empty list

  void updateEnquiry(List<EnquiryAddModel> newEnquiries) {
    state = newEnquiries; // Update with the new list of enquiries
  }

  void setEnquiry(EnquiryAddModel newEnquiry) {
    state = [newEnquiry]; // Update with a single enquiry
  }

  void addEnquiry(EnquiryAddModel newEnquiry) {
    state = [...state, newEnquiry]; // View a single enquiry to the list
  }

  void setAllEnquiries(List<EnquiryAddModel> newEnquiries) {
    state = newEnquiries; // View multiple enquiries to the list
  }
}
