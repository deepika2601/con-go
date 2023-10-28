import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/model/filterModel.dart';
import 'package:congobonmarche/model/mainmodel.dart';
import 'package:congobonmarche/model/searchModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  MainModel mainmodeldata = new MainModel();
  SearchModel sercherdata = new SearchModel();
  FilterModel filterdata = new FilterModel();
  final TextEditingController searchController = TextEditingController();

  List<CategoryList> _categorylist = [];
  List<CategoryList> get categoryList => _categorylist;
  List<Ads> _ads = [];
  List<Ads> get ads => _ads;

  Future categorylist() async {
    print("object data");
    ServiceWithoutbody _service = new ServiceWithoutbody(HOME);
    final response = await _service.data();
    _categorylist = [];
    _ads = [];
    mainmodeldata = MainModel.fromJson(response);
    print(mainmodeldata);
    print(mainmodeldata.data!.categoryList!.length);
    if (mainmodeldata.data != null) {
      if (mainmodeldata.data!.categoryList!.length > 0) {
        print(mainmodeldata.data!.categoryList![0].categoryId);
        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0; i < mainmodeldata.data!.categoryList!.length; i++) {
          _categorylist.add(mainmodeldata.data!.categoryList![i]);
        }
        // notifyListeners();
      }
    }
    if (mainmodeldata.data != null) {
      if (mainmodeldata.data!.ads!.length > 0) {
        print(mainmodeldata.data!.categoryList![0].categoryId);

        // _categorylist.addAll(mainmodeldata.data.categoryList);
        for (int i = 0; i < mainmodeldata.data!.ads!.length; i++) {
          _ads.add(mainmodeldata.data!.ads![i]);
        }
        // notifyListeners();
      }
    }

    return;
  }

  bool isNotifying = true;
  bool isfilterNotifying = true;
  Future serchcategorylist(String name) async {
    var data = {"name": name.trim()};
    Service _service = new Service(SEARCHBAR, data);
    final response = await _service.formdata();
    _categorylist = [];
    _ads = [];
    sercherdata = SearchModel.fromJson(response);

    if (sercherdata.data != null) {
      if (sercherdata.data!.category!.isNotEmpty) {
        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0; i < sercherdata.data!.category!.length; i++) {
          _categorylist.add(sercherdata.data!.category![i]);
        }
        // notifyListeners();
      }
    }
    if (sercherdata.data != null) {
      if (sercherdata.data!.ads!.isNotEmpty) {
        // _categorylist.addAll(mainmodeldata.data.categoryList);
        for (int i = 0; i < sercherdata.data!.ads!.length; i++) {
          _ads.add(sercherdata.data!.ads![i]);
        }
      }
    }

    return;
  }

  Future filtercategorylist() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var q = sharedPreferences.getString("q");
    var min = sharedPreferences.getString("min");
    var max = sharedPreferences.getString("max");
    var categoryid = sharedPreferences.getString(
      "categoryId",
    );
    var subcategoryid = sharedPreferences.getString("allsubcategoriesid");
    var barendid = sharedPreferences.getString("allbrandid");

    var countryid = sharedPreferences.getString("countryid");

    var stateid = sharedPreferences.getString(
      "statelist",
    );
    var cityid = sharedPreferences.getString("citylist");
    var data = {
      "q": q!.trim(),
      "category": categoryid!.trim(),
      "sub_category": subcategoryid!.trim(),
      "min_price": min!.trim(),
      "max_price": max!.trim(),
      "country": countryid!.trim(),
      "state": stateid!.trim(),
      "city": cityid!.trim()
    };
    Service _service = new Service(Filterhome, data);
    final response = await _service.formdata();

    _ads = [];
    filterdata = FilterModel.fromJson(response);

    if (filterdata.data != null) {
      // _categorylist.addAll(mainmodeldata.data.categoryList);
      for (int i = 0; i < filterdata.data!.length; i++) {
        _ads.add(filterdata.data![i]);
      }
      print(_ads);
    }
    // notifyListeners();
    return;
  }

  void fetchdata() {
    if (searchController.text == '' || searchController.text.isEmpty) {
      isNotifying = true;
      isfilterNotifying = true;
      notifyListeners();
      // return categorylist();
    } else {
      isNotifying = false;
      isfilterNotifying = true;
      notifyListeners();
      // return serchcategorylist(searchController.text.trim());
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
