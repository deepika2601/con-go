import 'package:congobonmarche/model/categoriesmodel.dart';

class GetBrandByCategoryId {
  String? status;
  String? message;
  List<GetBrandModel>? data;

  GetBrandByCategoryId({this.status, this.message, this.data});

  GetBrandByCategoryId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetBrandModel>[];
      json['data'].forEach((v) {
        data!.add(new GetBrandModel.fromJson(v));
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

class GetBrandModel {
  int? id;
  String? brandName;
  String? brandSlug;
  String? categoryId;
  String? productCount;
  String? createdAt;
  String? updatedAt;
  Categories? category;

  GetBrandModel(
      {this.id,
      this.brandName,
      this.brandSlug,
      this.categoryId,
      this.productCount,
      this.createdAt,
      this.updatedAt,
      this.category});

  GetBrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandSlug = json['brand_slug'];
    categoryId = json['category_id'];
    productCount = json['product_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Categories.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['brand_slug'] = this.brandSlug;
    data['category_id'] = this.categoryId;
    data['product_count'] = this.productCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}
