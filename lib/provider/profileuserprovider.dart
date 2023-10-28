import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/model/profileuserModel.dart';
import 'package:flutter/material.dart';

class ProfileUserProvider extends ChangeNotifier {
  ProfileUserModel profileuserModel = ProfileUserModel();

  List<ProfileUserData> _profileuserlist = [];
  List<ProfileUserData> get profileuserList => _profileuserlist;

  Future profileuserlist(String email) async {
    print("object data");
    var data = {
      'email': email,
    };
    Service _service = new Service(USERPROFILE, data);
    final response = await _service.formdata();
    print(response);
    _profileuserlist = [];
    profileuserModel = ProfileUserModel.fromJson(response);
    if (profileuserModel.data != null) {
      var profileuser = profileuserModel.data;

      _profileuserlist.add(profileuser!);

      notifyListeners();
    }
  }
}
