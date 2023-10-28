class AdsapprovedModel {
  bool? success;
  String? status;
  List<AdsapprovedData>? data;

  AdsapprovedModel({this.success, this.status, this.data});

  AdsapprovedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = <AdsapprovedData>[];
      json['data'].forEach((v) {
        data!.add(new AdsapprovedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdsapprovedData {
  int? id;
  String? title;
  String? slug;
  String? description;
  String? categoryId;
  String? subCategoryId;
  String? brandId;
  String? type;
  String? adCondition;
  String? model;
  String? price;
  String? isNegotiable;
  String? sellerName;
  String? sellerEmail;
  String? sellerPhone;
  String? countryId;
  String? stateId;
  String? cityId;
  String? address;
  String? videoUrl;
  String? status;
  String? pricePlan;
  String? markAdUrgent;
  String? view;
  String? maxImpression;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? latitude;
  String? longitude;
  List<Media>? media;

  AdsapprovedData(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.categoryId,
      this.subCategoryId,
      this.brandId,
      this.type,
      this.adCondition,
      this.model,
      this.price,
      this.isNegotiable,
      this.sellerName,
      this.sellerEmail,
      this.sellerPhone,
      this.countryId,
      this.stateId,
      this.cityId,
      this.address,
      this.videoUrl,
      this.status,
      this.pricePlan,
      this.markAdUrgent,
      this.view,
      this.maxImpression,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.latitude,
      this.longitude,
      this.media});

  AdsapprovedData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    brandId = json['brand_id'];
    type = json['type'];
    adCondition = json['ad_condition'];
    model = json['model'];
    price = json['price'];
    isNegotiable = json['is_negotiable'];
    sellerName = json['seller_name'];
    sellerEmail = json['seller_email'];
    sellerPhone = json['seller_phone'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    address = json['address'];
    videoUrl = json['video_url'];
    status = json['status'];
    pricePlan = json['price_plan'];
    markAdUrgent = json['mark_ad_urgent'];
    view = json['view'];
    maxImpression = json['max_impression'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['brand_id'] = this.brandId;
    data['type'] = this.type;
    data['ad_condition'] = this.adCondition;
    data['model'] = this.model;
    data['price'] = this.price;
    data['is_negotiable'] = this.isNegotiable;
    data['seller_name'] = this.sellerName;
    data['seller_email'] = this.sellerEmail;
    data['seller_phone'] = this.sellerPhone;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['video_url'] = this.videoUrl;
    data['status'] = this.status;
    data['price_plan'] = this.pricePlan;
    data['mark_ad_urgent'] = this.markAdUrgent;
    data['view'] = this.view;
    data['max_impression'] = this.maxImpression;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  int? id;
  String? userId;
  String? adId;
  String? postId;
  String? mediaName;
  String? type;
  String? isFeature;
  String? storage;
  String? ref;
  String? createdAt;
  String? updatedAt;

  Media(
      {this.id,
      this.userId,
      this.adId,
      this.postId,
      this.mediaName,
      this.type,
      this.isFeature,
      this.storage,
      this.ref,
      this.createdAt,
      this.updatedAt});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    adId = json['ad_id'];
    postId = json['post_id'];
    mediaName = json['media_name'];
    type = json['type'];
    isFeature = json['is_feature'];
    storage = json['storage'];
    ref = json['ref'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['ad_id'] = this.adId;
    data['post_id'] = this.postId;
    data['media_name'] = this.mediaName;
    data['type'] = this.type;
    data['is_feature'] = this.isFeature;
    data['storage'] = this.storage;
    data['ref'] = this.ref;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
