import 'package:get/get.dart';

class HomeController extends GetxController {
  var onPageChanged = 0.obs;

  onInit() {
    super.onInit();
  }

  void pageChanged(int index) {
    onPageChanged.value = index;
  }
}
