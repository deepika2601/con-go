import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/main.dart';
import 'package:flutter/material.dart';
import '../model/adsapprovedModel.dart';

class AdsapprovedProvider extends ChangeNotifier {
  AdsapprovedModel adsapprovedModel = AdsapprovedModel();

  List<AdsapprovedData> _adsapprovedlist = [];
  List<AdsapprovedData> get adsapprovedList => _adsapprovedlist;

  Future adsapprovedlist() async {
    print("object data");
    ServiceWithoutbody _service =
        new ServiceWithoutbody(ADSAPPROVED + "/${MyApp.userid}");
    final response = await _service.data();

    adsapprovedModel = AdsapprovedModel.fromJson(response);
    _adsapprovedlist = [];
    if (adsapprovedModel.data != null) {
      if (adsapprovedModel.data!.length > 0) {
        print(adsapprovedModel.data!.length);

        for (int i = 0; i < adsapprovedModel.data!.length; i++) {
          _adsapprovedlist.add(adsapprovedModel.data![i]);
        }
      }
    }
    notifyListeners();

    return;
  }

  Future adspendinglist() async {
    print("object data");
    ServiceWithoutbody _service =
        new ServiceWithoutbody(PendingAdByCustomerId + "/${MyApp.userid}");
    final response = await _service.data();

    adsapprovedModel = AdsapprovedModel.fromJson(response);
    _adsapprovedlist = [];
    if (adsapprovedModel.data != null) {
      if (adsapprovedModel.data!.length > 0) {
        print(adsapprovedModel.data!.length);

        for (int i = 0; i < adsapprovedModel.data!.length; i++) {
          _adsapprovedlist.add(adsapprovedModel.data![i]);
        }
      }
    }
    notifyListeners();

    return;
  }
}
