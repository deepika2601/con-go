import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/model/PpemiumAdsmodel.dart';
import 'package:congobonmarche/model/addssearchmodels.dart';
import 'package:congobonmarche/model/adsDetailsModel.dart';
import 'package:congobonmarche/model/adsapprovedModel.dart';
import 'package:congobonmarche/model/alladsModel.dart';
import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:congobonmarche/model/mainmodel.dart';
import 'package:flutter/material.dart';

class AdsProvider extends ChangeNotifier {
  AllAdsModel allAdsModel = AllAdsModel();
  AdsSearchModels adsSearchModels = AdsSearchModels();
  AdsDetailsModel adsDetailsModel = AdsDetailsModel();
  MainModel adssubcategoriesModel = MainModel();
  bool adssubcatgoriesFetch = false;
  PremiumAdsmodel premiumAdsmodel = PremiumAdsmodel();

  List<AllAdsModelData> _allAdsList = [];
  List<AllAdsModelData> get allAdsList => _allAdsList;

  List<AllAdsModelData> _allAdsPremimum = [];
  List<AllAdsModelData> get allAdsPermium => _allAdsPremimum;

  List<Ads> _adsSubcategoriesList = [];
  List<Ads> get adsSubcategoriesList => _adsSubcategoriesList;

  List<AllAdsModelData> _allAdsDetailsList = [];
  List<AllAdsModelData> get allAdsDetailsList => _allAdsDetailsList;
  bool allAdsDetailsLoading = false;

  bool allAdsSearch = false;

  Future allAdsdata(String Page) async {
    print("object data");
    allAdsSearch = false;
    ServiceWithoutbody _service =
        new ServiceWithoutbody(ADSBOUTIQUES + "?page=$Page");
    final response = await _service.data();
    _allAdsList = [];

    allAdsModel = AllAdsModel.fromJson(response);
    allAdsDetailsLoading = false;

    if (allAdsModel.data?.alladsdata != null) {
      if (allAdsModel.data!.alladsdata!.length > 0) {
        print(allAdsModel.data!.alladsdata!.length);

        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0; i < allAdsModel.data!.alladsdata!.length; i++) {
          _allAdsList.add(allAdsModel.data!.alladsdata![i]);
        }
        notifyListeners();
      }
    }

    return;
  }

  Future allAdsdataserch(String name) async {
    var data = {"name": name};

    Service _service = new Service(ADSBOUTIQUESSEARCH, data);
    final response = await _service.formdata();
    _allAdsList = [];
    adsSearchModels = AdsSearchModels.fromJson(response);
    print("object bnfbhjrhfgchfrgvgcfyghyvg");

    if (adsSearchModels.data != null) {
      if (adsSearchModels.data!.isNotEmpty) {
        for (int i = 0; i < adsSearchModels.data!.length; i++) {
          _allAdsList.add(adsSearchModels.data![i]);
        }
      }
    }
    notifyListeners();

    return;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // statelistdata();
    allAdsdataserch('');
  }

  Future premiumAdsdata() async {
    print("object data");
    ServiceWithoutbody _service = new ServiceWithoutbody(premiumAds);
    final response = await _service.data();
    _allAdsPremimum = [];
    premiumAdsmodel = PremiumAdsmodel.fromJson(response);

    if (premiumAdsmodel.data != null) {
      if (premiumAdsmodel.data!.length > 0) {
        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0; i < premiumAdsmodel.data!.length; i++) {
          _allAdsPremimum.add(premiumAdsmodel.data![i]);
        }
      }
    }
    notifyListeners();

    return;
  }

  Future adsdetailsdata(String adsids) async {
    var bodydata = {"id": adsids};
    Service _service = new Service(ADSDETAILS, bodydata);
    allAdsDetailsLoading = true;
    // notifyListeners();
    final response = await _service.formdata();
    allAdsDetailsLoading = false;
    // notifyListeners();
    _allAdsDetailsList = [];
    notifyListeners();
    adsDetailsModel = AdsDetailsModel.fromJson(response);

    if (adsDetailsModel.data?.ad != null) {
      // _categorylist.addAll(mainmodeldata.data.categoryList);

      var adsDetais = adsDetailsModel.data?.ad;
      try {
        // assert(adsDetais is List);

        _allAdsDetailsList.add(adsDetais!);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
    print(adsDetailsModel.status);
    // notifyListeners();

    return;
  }

  Future adssubcategoriesdata(String subcategoriesname) async {
    _adsSubcategoriesList = [];
    print(ADSSUBCATEGORYDETAILS + subcategoriesname);

    ServiceWithoutbody _service =
        new ServiceWithoutbody(ADSSUBCATEGORYDETAILS + subcategoriesname);
    final response = await _service.data();

    adssubcategoriesModel = MainModel.fromJson(response);

    if (adssubcategoriesModel.data?.ads != null) {
      if (adssubcategoriesModel.data!.ads!.length > 0) {
        // _categorylist.addAll(mainmodeldata.data.categoryList);

        for (int i = 0; i < adssubcategoriesModel.data!.ads!.length; i++) {
          _adsSubcategoriesList.add(adssubcategoriesModel.data!.ads![i]);
        }
      } else {
        adssubcatgoriesFetch = true;
      }
    } else {
      adssubcatgoriesFetch = true;
    }

    notifyListeners();

    return;
  }
}
