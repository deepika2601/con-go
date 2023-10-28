import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/model/addresslistmodel.dart';
import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:congobonmarche/model/cityModel.dart';
import 'package:congobonmarche/model/getBrandByCategoryIdModel.dart';
import 'package:congobonmarche/model/stateModel.dart';
import 'package:congobonmarche/model/subCategoriesmodel.dart';
import 'package:flutter/material.dart';
import '../model/adsapprovedModel.dart';

class AddressProvider extends ChangeNotifier {
  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  AddressListModel addresslistModel = AddressListModel();
  CategoriesModel allcategoriesModel = CategoriesModel();
  SubCategoriesModel allsubCategoriesModel = SubCategoriesModel();
  GetBrandByCategoryId allbrand = GetBrandByCategoryId();

  List<StatelistModel> _statelistmodel = [];
  List<StatelistModel> get statelistmodel => _statelistmodel;
  bool allstatelistFetch = false;
  int allstatelistindex = 0;

  List<CityListModel> _citylistmodel = [];
  List<CityListModel> get citylistmodel => _citylistmodel;
  bool allcitylistFetch = false;
  int allcitylistindex = 0;

  List<AddressList> _addresslistmodel = [];
  List<AddressList> get addresslistmodels => _addresslistmodel;

  List<Categories> _getalllistmodel = [];
  List<Categories> get getalllistmodels => _getalllistmodel;
  bool allcategoriesFetch = false;
  int allcategoriesindex = 0;

  List<Categories> _getsubcategorieslistmodel = [];
  List<Categories> get getsubcategorieslistmodels => _getsubcategorieslistmodel;
  bool allsubcategoriesFetch = false;
  int allsubcategoriesindex = 0;

  List<GetBrandModel> _getbrandlistmodel = [];
  List<GetBrandModel> get getbrandlistmodels => _getbrandlistmodel;
  bool allbrandFetch = false;
  int allbrandindex = 0;

  Future statelistdata(String countryid) async {
    print("object data");
    var data = {'id': countryid};
    Service _service = new Service(Statebycountry, data);
    final response = await _service.formdata();
    _statelistmodel = [];
    // notifyListeners();
    stateModel = StateModel.fromJson(response);
    _statelistmodel
        .add(StatelistModel(id: 0, stateName: "Veuillez sélectionner l'état"));
    if (stateModel.data != null) {
      if (stateModel.data!.isNotEmpty) {
        for (int i = 0; i < stateModel.data!.length; i++) {
          _statelistmodel.add(stateModel.data![i]);
        }
        allstatelistFetch = true;
        notifyListeners();
      }
    }
    print("object allstatelistFetch");

    print(statelistmodel);

    return;
  }

  Future citylistdata(String stateid) async {
    print("object data");
    var data = {'id': stateid};
    Service _service = new Service(Citybystateid, data);
    final response = await _service.formdata();
    _citylistmodel = [];
    notifyListeners();
    cityModel = CityModel.fromJson(response);
    _citylistmodel
        .add(CityListModel(id: 0, cityName: "Veuillez sélectionner la ville"));

    if (cityModel.data != null) {
      if (cityModel.data!.isNotEmpty) {
        for (int i = 0; i < cityModel.data!.length; i++) {
          _citylistmodel.add(cityModel.data![i]);
        }
        allcitylistFetch = true;
        notifyListeners();
      }
    }

    return;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // statelistdata();
  }

  Future addresslistdata() async {
    print("object data");
    var data = {'id': MyApp.userid};
    Service _service = new Service(AddressLists, data);
    final response = await _service.formdata();
    _addresslistmodel = [];
    notifyListeners();
    addresslistModel = AddressListModel.fromJson(response);

    if (addresslistModel.data != null) {
      if (addresslistModel.data!.isNotEmpty) {
        for (int i = 0; i < addresslistModel.data!.length; i++) {
          _addresslistmodel.add(addresslistModel.data![i]);
        }
        notifyListeners();
      }
    }

    return;
  }

  Future allcategorieslistdata() async {
    print("object data");

    ServiceWithoutbody _service = new ServiceWithoutbody(AllgetallCategories);
    final response = await _service.data();
    _getalllistmodel = [];
    notifyListeners();
    allcategoriesModel = CategoriesModel.fromJson(response);
    _getalllistmodel.add(Categories(
        id: "0",
        categoryId: "0",
        categoryName: "Veuillez sélectionner la catégorie"));
    if (allcategoriesModel.data != null) {
      if (allcategoriesModel.data!.categories!.isNotEmpty) {
        for (int i = 0; i < allcategoriesModel.data!.categories!.length; i++) {
          _getalllistmodel.add(allcategoriesModel.data!.categories![i]);
        }
        allcategoriesFetch = true;

        notifyListeners();
      }
    }

    return;
  }

  Future allsubcategoryistdata(String id) async {
    print("object data");

    ServiceWithoutbody _service =
        new ServiceWithoutbody(SUBCATEGORYNEW + '/$id');
    final response = await _service.data();
    _getsubcategorieslistmodel = [];
    notifyListeners();
    allsubCategoriesModel = SubCategoriesModel.fromJson(response);
    _getsubcategorieslistmodel.add(Categories(
        id: "0",
        categoryId: "0",
        categoryName: "Veuillez sélectionner une sous-catégorie"));

    if (allsubCategoriesModel.data != null) {
      if (allsubCategoriesModel.data!.subCategories!.isNotEmpty) {
        for (int i = 0;
            i < allsubCategoriesModel.data!.subCategories!.length;
            i++) {
          _getsubcategorieslistmodel
              .add(allsubCategoriesModel.data!.subCategories![i]);
        }
        allsubcategoriesFetch = true;

        notifyListeners();
      }
    }

    return;
  }

  Future allbrandlistdata(String id) async {
    print("object data");
    var data = {'id': id};

    Service _service = new Service(Brandbycategory, data);
    final response = await _service.formdata();
    _getbrandlistmodel = [];
    notifyListeners();
    allbrand = GetBrandByCategoryId.fromJson(response);

    if (allbrand.data != null) {
      if (allbrand.data!.isNotEmpty) {
        _getbrandlistmodel.add(GetBrandModel(
            id: 0, categoryId: "0", brandName: "choisissez une Marque"));
        for (int i = 0; i < allbrand.data!.length; i++) {
          _getbrandlistmodel.add(allbrand.data![i]);
        }
        allbrandFetch = true;
        notifyListeners();
      }
    }

    return;
  }
}
