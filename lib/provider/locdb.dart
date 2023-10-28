import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocDb {
  LocDb._internal();
  static final LocDb _db = LocDb._internal();
  factory LocDb() {
    return _db;
  }
  bool loginapp = false;

  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    MyApp.AUTH_TOKEN_VALUE = preferences.getString(StringFile.authtoken);
    MyApp.userid = preferences.getString(StringFile.userid);
    MyApp.email_VALUE = preferences.getString(StringFile.email);
    if (MyApp.userid == null || MyApp.userid == false) {
      return false;
    } else {
      return true;
    }
  }
}
