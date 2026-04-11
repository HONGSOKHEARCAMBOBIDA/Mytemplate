class ShiftResModel {
  List<Data>? data;

  ShiftResModel({this.data});

  ShiftResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  bool? isActive;
  int? branchId;
  String? branchName;

  Data({this.id, this.name, this.isActive, this.branchId, this.branchName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    return data;
  }
}
