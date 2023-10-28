import 'package:congobonmarche/model/alladsModel.dart';

class AdsDetailsModel {
  bool? success;
  String? status;
  Data? data;
  String? url;

  AdsDetailsModel({this.success, this.status, this.data, this.url});

  AdsDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['url'] = this.url;
    return data;
  }
}

class Data {
  AllAdsModelData? ad;
  String? title;

  Data({this.ad, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    ad = json['ad'] != null ? new AllAdsModelData.fromJson(json['ad']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ad != null) {
      data['ad'] = this.ad!.toJson();
    }
    data['title'] = this.title;
    return data;
  }
}
