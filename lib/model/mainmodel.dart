import 'package:congobonmarche/model/adsapprovedModel.dart';

class MainModel {
  bool? success;
  String? status;
  Data? data;

  MainModel({this.success, this.status, this.data});

  MainModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CategoryList>? categoryList;
  List<Ads>? ads;

  Data({this.categoryList, this.ads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? categoryName;
  String? categorySlug;
  String? productCount;
  String? faIcon;
  String? parentId;
  String? categoryId;
  String? userId;
  String? isFeature;
  String? type;
  String? mediaName;
  String? storage;

  CategoryList(
      {this.categoryName,
      this.categorySlug,
      this.productCount,
      this.faIcon,
      this.parentId,
      this.categoryId,
      this.userId,
      this.isFeature,
      this.type,
      this.mediaName,
      this.storage});

  CategoryList.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    productCount = json['product_count'];
    faIcon = json['fa_icon'];
    parentId = json['parent_id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    isFeature = json['is_feature'];
    type = json['type'];
    mediaName = json['media_name'];
    storage = json['storage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_slug'] = this.categorySlug;
    data['product_count'] = this.productCount;
    data['fa_icon'] = this.faIcon;
    data['parent_id'] = this.parentId;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['is_feature'] = this.isFeature;
    data['type'] = this.type;
    data['media_name'] = this.mediaName;
    data['storage'] = this.storage;
    return data;
  }
}

class Ads {
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
  String? adId;
  String? mediaName;
  String? storage;
  String? cId;
  String? categoryName;
  String? categorySlug;
  String? faIcon;
  String? colorClass;
  String? productCount;
  List<Media>? media;

  Ads({
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
    this.adId,
    this.mediaName,
    this.storage,
    this.cId,
    this.categoryName,
    this.categorySlug,
    this.faIcon,
    this.colorClass,
    this.productCount,
    this.media,
  });

  Ads.fromJson(Map<String, dynamic> json) {
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
    view = json['view'];
    maxImpression = json['max_impression'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    adId = json['ad_id'];
    mediaName = json['media_name'];
    storage = json['storage'];
    cId = json['c_id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    faIcon = json['fa_icon'];
    colorClass = json['color_class'];
    productCount = json['product_count'];
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
    data['ad_id'] = this.adId;
    data['media_name'] = this.mediaName;
    data['storage'] = this.storage;
    data['c_id'] = this.cId;
    data['category_name'] = this.categoryName;
    data['category_slug'] = this.categorySlug;
    data['fa_icon'] = this.faIcon;
    data['color_class'] = this.colorClass;
    data['product_count'] = this.productCount;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
