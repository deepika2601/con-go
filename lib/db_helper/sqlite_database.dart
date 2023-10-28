import 'package:get_storage/get_storage.dart';

class SqliteDatabase{
  static GetStorage box = GetStorage();

  static writeData(String key, dynamic value) async{
    await box.write(key, value);
  }

  static readData(String key) {
    return  box.read(key);
  }

  static deleteData(String key)async {
    await box.remove(key);
  }

  static eraseData()async{
    await box.erase();
  }

}
