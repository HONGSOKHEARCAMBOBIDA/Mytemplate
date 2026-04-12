class ShiftSessionResModel {
  List<Data>? data;

  ShiftSessionResModel({this.data});

  ShiftSessionResModel.fromJson(Map<String, dynamic> json) {
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
  String? sessionName;
  int? shiftId;
  String? shiftName;
  int? branchId;
  String? branchName;
  int? shiftOrder;
  String? startTime;
  String? endTime;
  bool? isActive;

  Data(
      {this.id,
      this.sessionName,
      this.shiftId,
      this.shiftName,
      this.branchId,
      this.branchName,
      this.shiftOrder,
      this.startTime,
      this.endTime,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionName = json['session_name'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    shiftOrder = json['shift_order'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_name'] = this.sessionName;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['shift_order'] = this.shiftOrder;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_active'] = this.isActive;
    return data;
  }
}
