import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class DialogHelper{
  RxBool isCheck = false.obs;

  static void hideLoading(){
    if(Get.isDialogOpen!){
      Get.back();
    }
  }

  static Future<void> showFlutterToast({required String strMsg}) async {
    await Fluttertoast.showToast(msg: strMsg);
  }
}