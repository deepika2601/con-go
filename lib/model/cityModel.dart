class CityModel {
  String? status;
  String? message;
  List<CityListModel>? data;

  CityModel({this.status, this.message, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CityListModel>[];
      json['data'].forEach((v) {
        data!.add(new CityListModel.fromJson(v));
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

class CityListModel {
  int? id;
  String? cityName;
  String? stateId;
  States? state;

  CityListModel({this.id, this.cityName, this.stateId, this.state});

  CityListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    stateId = json['state_id'];
    state = json['state'] != null ? new States.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    data['state_id'] = this.stateId;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    return data;
  }
}

class States {
  int? id;
  String? stateName;
  String? countryId;

  States({this.id, this.stateName, this.countryId});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    data['country_id'] = this.countryId;
    return data;
  }
}
