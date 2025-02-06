import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadsViewModel {
  String leadsId; // Updated to camelCase naming convention
  String userPhNo;
  String userName;
  String postType;
  String categoryName;
  String fishName;
  int fishQty;
  String qtyUom;
  DateTime postDate; // Updated field name
  String remarks;
  String refId;
  DateTime createdDate;

  LeadsViewModel({
    required this.leadsId,
    required this.userPhNo,
    required this.userName,
    required this.postType,
    required this.categoryName,
    required this.fishName,
    required this.fishQty,
    required this.qtyUom,
    required this.postDate,
    required this.remarks,
    required this.refId,
    required this.createdDate,
  });

  factory LeadsViewModel.fromJson(Map<String, dynamic> json) {
    return LeadsViewModel(
      leadsId: json["leads_id"] ?? "", // Updated field name
      userPhNo: json["user_phno"] ?? "",
      userName: json["user_name"] ?? "",
      postType: json["post_type"] ?? "", // Updated field name
      categoryName: json["cat_name"] ?? "", // Updated field name
      fishName: json["post_fish_name"] ?? "", // Updated field name
      fishQty: int.parse(json["post_fish_qty"] ?? "0"), // Updated field name
      qtyUom: json["post_qty_uom"] ?? "", // Updated field name
      postDate: DateTime.parse(json["post_date"] ?? ""), // Updated field name
      remarks: json["post_remarks"] ?? "",
      refId: json["ref_id"] ?? "",
      createdDate: DateTime.parse(json["created_date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leads_id": leadsId,
      "user_phno": userPhNo,
      "user_name": userName,
      "post_type": postType,
      "cat_name": categoryName,
      "post_fish_name": fishName,
      "post_fish_qty": fishQty,
      "post_qty_uom": qtyUom,
      "post_date": postDate.toIso8601String(),
      "post_remarks": remarks,
      "ref_id": refId,
      "created_date": createdDate.toIso8601String(),
    };
  }
}

class LeadsViewModelNotifier extends StateNotifier<List<LeadsViewModel>> {
  LeadsViewModelNotifier() : super([]); // Initialize with an empty list

  void setLeads(LeadsViewModel newLeads) {
    state = [newLeads]; // Update with a single leads
  }

  void addLeads(List<LeadsViewModel> newLeads) {
    state = [...state, ...newLeads]; // View a single leads to the list
  }

  // void addEnquiries(List<EnquiryViewModel> newEnquiries) {
  //   state = [...state, ...newEnquiries]; // Add new enquiries to the list
  // }

  void setAllLeads(List<LeadsViewModel> newLeads) {
    state = newLeads; // View multiple leads to the list
  }
}
