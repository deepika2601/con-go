import 'package:congobonmarche/model/categoriesmodel.dart';

class SubCategoriesModel {
  bool? success;
  String? status;
  Data? data;

  SubCategoriesModel({this.success, this.status, this.data});

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories>? subCategories;

  Data({this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sub_categories'] != null) {
      subCategories = <Categories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
