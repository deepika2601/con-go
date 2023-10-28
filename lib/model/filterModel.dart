import 'package:congobonmarche/model/mainmodel.dart';

class FilterModel {
  String? status;
  String? message;
  List<Ads>? data;

  FilterModel({this.status, this.message, this.data});

  FilterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Ads>[];
      json['data'].forEach((v) {
        data!.add(new Ads.fromJson(v));
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
