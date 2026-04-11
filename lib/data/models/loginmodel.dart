class LoginResModel {
  Data? data;

  LoginResModel({this.data});

  LoginResModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? contact;
  String? deviceName;
  String? ipaddress;
  String? token;
  int? roleId;
  List<Parts>? parts;
  int? manageBranh;
  List<Permissions>? permissions;

  Data(
      {this.id,
      this.name,
      this.contact,
      this.deviceName,
      this.ipaddress,
      this.token,
      this.roleId,
      this.parts,
      this.manageBranh,
      this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    deviceName = json['device_name'];
    ipaddress = json['ipaddress'];
    token = json['Token'];
    roleId = json['role_id'];
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(new Parts.fromJson(v));
      });
    }
    manageBranh = json['manage_branh'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['device_name'] = this.deviceName;
    data['ipaddress'] = this.ipaddress;
    data['Token'] = this.token;
    data['role_id'] = this.roleId;
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    data['manage_branh'] = this.manageBranh;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parts {
  int? id;
  int? partId;
  String? partName;
  String? partDisplayName;

  Parts({this.id, this.partId, this.partName, this.partDisplayName});

  Parts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partId = json['part_id'];
    partName = json['part_name'];
    partDisplayName = json['part_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['part_id'] = this.partId;
    data['part_name'] = this.partName;
    data['part_display_name'] = this.partDisplayName;
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? displayName;
  String? groupName;
  int? shortName;

  Permissions(
      {this.id, this.name, this.displayName, this.groupName, this.shortName});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    groupName = json['group_name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['group_name'] = this.groupName;
    data['short_name'] = this.shortName;
    return data;
  }
}
