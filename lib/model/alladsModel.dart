import 'package:congobonmarche/model/adsapprovedModel.dart';

class AllAdsModel {
  String? status;
  String? message;
  Data? data;

  AllAdsModel({this.status, this.message, this.data});

  AllAdsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<AllAdsModelData>? alladsdata;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.alladsdata,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      alladsdata = <AllAdsModelData>[];
      json['data'].forEach((v) {
        alladsdata!.add(new AllAdsModelData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.alladsdata != null) {
      data['data'] = this.alladsdata!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class AllAdsModelData {
  String? id;
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

  AllAdsModelData({
    this.id,
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
    this.media,
  });

  AllAdsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
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
    view = json['view'].toString();
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
