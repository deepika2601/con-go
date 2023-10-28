import 'package:congobonmarche/model/profileuserModel.dart';

class AddressListModel {
  String? status;
  String? message;
  List<AddressList>? data;

  AddressListModel({this.status, this.message, this.data});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressList>[];
      json['data'].forEach((v) {
        data!.add(new AddressList.fromJson(v));
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

class AddressList {
  int? id;
  String? userId;
  String? address;
  String? zipcode;
  String? cityId;
  String? status;
  String? createdAt;
  String? updatedAt;

  String? countryId;
  String? stateId;
  ProfileUserData? user;

  AddressList(
      {this.id,
      this.userId,
      this.address,
      this.zipcode,
      this.cityId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.countryId,
      this.stateId,
      this.user});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    zipcode = json['zipcode'];
    cityId = json['city_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    user = json['user'] != null
        ? new ProfileUserData.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['zipcode'] = this.zipcode;
    data['city_id'] = this.cityId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
