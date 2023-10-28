class StateModel {
  String? status;
  String? message;
  List<StatelistModel>? data;

  StateModel({this.status, this.message, this.data});

  StateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StatelistModel>[];
      json['data'].forEach((v) {
        data!.add(new StatelistModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatelistModel {
  int? id;
  String? stateName;
  String? countryId;
  Country? country;

  StatelistModel({this.id, this.stateName, this.countryId, this.country});

  StatelistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
    countryId = json['country_id'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    data['country_id'] = this.countryId;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? countryCode;
  String? countryName;

  Country({this.id, this.countryCode, this.countryName});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    return data;
  }
}
