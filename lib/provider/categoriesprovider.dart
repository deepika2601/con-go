import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoriesModel categoriesModel = CategoriesModel();

  List<Categories> _categorieslist = [];
  List<Categories> get categoriesList => _categorieslist;

  Future categorylist() async {
    print("object data");
    ServiceWithoutbody _service = new ServiceWithoutbody(CATEGORY);
    final response = await _service.data();
    _categorieslist = [];
    categoriesModel = CategoriesModel.fromJson(response);
    if (categoriesModel.data != null) {
      if (categoriesModel.data!.categories!.length > 0) {
        print(categoriesModel.data!.categories!.length);

        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0; i < categoriesModel.data!.categories!.length; i++) {
          _categorieslist.add(categoriesModel.data!.categories![i]);
        }
        notifyListeners();
      }
    }

    return;
  }
}
