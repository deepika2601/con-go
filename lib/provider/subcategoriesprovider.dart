import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:congobonmarche/model/subCategoriesmodel.dart';
import 'package:flutter/material.dart';

class SubCategoriesProvider extends ChangeNotifier {
  SubCategoriesModel subcategoriesModel = SubCategoriesModel();

  List<Categories> _subcategorieslist = [];
  List<Categories> get subcategoriesList => _subcategorieslist;

  Future subCategorylist(String subcategoryname) async {
    print("object data");
    ServiceWithoutbody _service =
        new ServiceWithoutbody(SUBCATEGORYNEW + '/$subcategoryname');
    final response = await _service.data();

    subcategoriesModel = SubCategoriesModel.fromJson(response);
    _subcategorieslist = [];
    if (subcategoriesModel.data != null) {
      if (subcategoriesModel.data!.subCategories!.length > 0) {
        print(subcategoriesModel.data!.subCategories!.length);

        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0;
            i < subcategoriesModel.data!.subCategories!.length;
            i++) {
          _subcategorieslist.add(subcategoriesModel.data!.subCategories![i]);
        }
        notifyListeners();
      }
    }

    return;
  }
}
