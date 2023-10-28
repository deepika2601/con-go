class CategoriesModel {
  bool? success;
  String? status;
  Data? data;

  CategoriesModel({this.success, this.status, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'].toString();
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
  List<Categories>? categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
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

  Categories(
      {this.id,
      this.categoryName,
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

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
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
    data['id'] = this.id;
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
