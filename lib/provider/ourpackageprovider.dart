import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/model/ourpackageModel.dart';
import 'package:flutter/material.dart';

class OurPackageProvider extends ChangeNotifier {
  OurPackageModel ourpackageModel = OurPackageModel();

  List<OurpackageData> _ourpackagelist = [];
  List<OurpackageData> get ourpackageList => _ourpackagelist;

  Future ourpackagelist() async {
    print("object data");
    ServiceWithHeader _service = new ServiceWithHeader(OURPACKAGE);
    final response = await _service.data();
    print(response);

    ourpackageModel = OurPackageModel.fromJson(response);
    if (ourpackageModel.data != null) {
      if (ourpackageModel.data!.length > 0) {
        print(ourpackageModel.data!.length);

        _ourpackagelist = [];
        for (int i = 0; i < ourpackageModel.data!.length; i++) {
          _ourpackagelist.add(ourpackageModel.data![i]);
        }
        notifyListeners();
      }
    }

    return;
  }
}
