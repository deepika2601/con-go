import 'package:congobonmarche/model/adsapprovedModel.dart';
import 'package:congobonmarche/model/alladsModel.dart';

class PremiumAdsmodel {
  String? status;
  String? message;
  List<AllAdsModelData>? data;

  PremiumAdsmodel({this.status, this.message, this.data});

  PremiumAdsmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AllAdsModelData>[];
      json['data'].forEach((v) {
        data!.add(new AllAdsModelData.fromJson(v));
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
