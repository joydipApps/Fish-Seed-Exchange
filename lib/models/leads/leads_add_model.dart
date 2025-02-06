import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadsAddModel {
  String leadsId;
  String userPhNo;
  String userName;
  String categoryName;
  String fishName;
  int fishQty;
  String qtyUom;
  DateTime postDate;
  String postType;
  String refId;
  String remarks;

  LeadsAddModel({
    required this.leadsId,
    required this.userPhNo,
    required this.userName,
    required this.categoryName,
    required this.fishName,
    required this.fishQty,
    required this.qtyUom,
    required this.postDate,
    required this.postType,
    required this.refId,
    required this.remarks,
  });

  factory LeadsAddModel.fromJson(Map<String, dynamic> json) {
    return LeadsAddModel(
      leadsId: json["leads_id"] ?? "",
      userPhNo: json["user_phno"] ?? "",
      userName: json["user_name"] ?? "",
      categoryName: json["cat_name"] ?? "",
      fishName: json["post_fish_name"] ?? "",
      fishQty: json["post_fish_qty"] ?? 0,
      qtyUom: json["post_qty_uom"] ?? "",
      postDate: DateTime.parse(json["post_date"] ?? ""),
      postType: json["post_type"] ?? "",
      refId: json["ref_id"] ?? "",
      remarks: json["post_remarks"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "leads_id": leadsId,
      "user_phno": userPhNo,
      "user_name": userName,
      "cat_name": categoryName,
      "post_fish_name": fishName,
      "post_fish_qty": fishQty,
      "post_qty_uom": qtyUom,
      "post_date": postDate.toIso8601String(),
      "post_type": postType,
      "ref_id": refId,
      "post_remarks": remarks,
    };
  }
}

class LeadsAddModelNotifier extends StateNotifier<List<LeadsAddModel>> {
  LeadsAddModelNotifier() : super([]); // Initialize with an empty list

  void updateLeads(List<LeadsAddModel> newLeads) {
    state = newLeads; // Update with the new list of leads
  }
}
