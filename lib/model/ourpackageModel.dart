class OurPackageModel {
  String? status;
  String? message;
  List<OurpackageData>? data;

  OurPackageModel({this.status, this.message, this.data});

  OurPackageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OurpackageData>[];
      json['data'].forEach((v) {
        data!.add(new OurpackageData.fromJson(v));
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

class OurpackageData {
  int? id;
  String? name;
  String? userId;
  String? slug;
  String? stripePlan;
  String? cost;
  String? freeAds;
  String? urgentAds;
  String? additionalImg;
  String? premiumAds;
  String? interval;
  String? description;
  String? createdAt;
  String? updatedAt;

  OurpackageData(
      {this.id,
      this.name,
      this.userId,
      this.slug,
      this.stripePlan,
      this.cost,
      this.freeAds,
      this.urgentAds,
      this.additionalImg,
      this.premiumAds,
      this.interval,
      this.description,
      this.createdAt,
      this.updatedAt});

  OurpackageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    slug = json['slug'];
    stripePlan = json['stripe_plan'];
    cost = json['cost'];
    freeAds = json['free_ads'];
    urgentAds = json['urgent_ads'];
    additionalImg = json['additional_img'];
    premiumAds = json['premium_ads'];
    interval = json['interval'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['slug'] = this.slug;
    data['stripe_plan'] = this.stripePlan;
    data['cost'] = this.cost;
    data['free_ads'] = this.freeAds;
    data['urgent_ads'] = this.urgentAds;
    data['additional_img'] = this.additionalImg;
    data['premium_ads'] = this.premiumAds;
    data['interval'] = this.interval;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
