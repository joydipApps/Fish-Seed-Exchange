import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnquiryViewModel {
  String enquiryId;
  String userPhNo;
  String userName;
  String userType;
  String categoryName;
  String fishName;
  int fishQty;
  String qtyUom;
  String fishSize;
  DateTime requiredDate;
  String remarks;
  DateTime createdDate;

  EnquiryViewModel({
    required this.enquiryId,
    required this.userPhNo,
    required this.userName,
    required this.userType,
    required this.fishName,
    required this.categoryName,
    required this.fishQty,
    required this.qtyUom,
    required this.fishSize,
    required this.requiredDate,
    required this.remarks,
    required this.createdDate,
  });

  factory EnquiryViewModel.fromJson(Map<String, dynamic> json) {
    return EnquiryViewModel(
      enquiryId: json["enquiry_id"] ?? "",
      userPhNo: json["user_phno"] ?? "",
      userName: json["user_name"] ?? "",
      userType: json["user_type"] ?? "",
      categoryName: json["cat_name"] ?? "",
      fishName: json["fish_name"] ?? "",
      fishQty: int.parse(json["fish_qty"] ?? "0"),
      qtyUom: json["qty_uom"] ?? "",
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
      "user_name": userName,
      "user_type": userType,
      "cat_name": fishName,
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

class EnquiryViewModelNotifier extends StateNotifier<List<EnquiryViewModel>> {
  EnquiryViewModelNotifier() : super([]); // Initialize with an empty list

  void setEnquiry(EnquiryViewModel newEnquiry) {
    state = [newEnquiry]; // Update with a single enquiry
  }

  void addEnquiry(EnquiryViewModel newEnquiry) {
    state = [...state, newEnquiry]; // View a single enquiry to the list
  }

  void addEnquiries(List<EnquiryViewModel> newEnquiries) {
    state = [...state, ...newEnquiries]; // Add new enquiries to the list
  }

  void setAllEnquiries(List<EnquiryViewModel> newEnquiries) {
    state = newEnquiries; // View multiple enquiries to the list
  }

  void updateEnquiry(EnquiryViewModel updatedEnquiry) {
    state = [
      for (final enquiry in state)
        if (enquiry.enquiryId == updatedEnquiry.enquiryId)
          updatedEnquiry
        else
          enquiry
    ];
  }
}
