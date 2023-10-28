
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';
import '../utils/string_file.dart';

class DialogHelper {
  //show error dialog
  static void showInfoDialog(
      {String title = StringFile.app_name,
      String? description = 'Something went wrong'}) {
    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.mediaQuery.size.height * 0.01,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.mediaQuery.size.height * 0.02,
              ),
              Text(
                description ?? '',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (Get.isDialogOpen!) Get.back();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  //show toast

  static void showFlutterToast({required String strMsg}) async {
    await Fluttertoast.showToast(msg: strMsg);
  }

  //show logout

  static void showLogoutPopup(BuildContext context) async {
    await Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Get.width,
            height: 40,
            color: colorPrimary,
            child: Center(
              child: Text(
                StringFile.logout,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: colorWhite,
                //    fontFamily: Contants().FONT_KEY_NAME_AMAZON,
                    fontWeight: FontWeight.w400,
                    fontSize: isMobile(context)
                        ? MyFontSize().mediumTextSizeMobile
                        : MyFontSize().mediumTextSizeTablet),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringFile.logoutDes,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: colorBlack,
               // fontFamily: Contants().FONT_KEY_NAME_AMAZON,
                fontWeight: FontWeight.w300,
                fontSize: isMobile(context)
                    ? MyFontSize().smallTextSizeMobile
                    : MyFontSize().smallTextSizeTablet),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      StringFile.cancel,
                      style: TextStyle(
                          color: colorWhite,
                         // fontFamily: Contants().FONT_KEY_NAME_AMAZON,
                          fontSize: isMobile(context)
                              ? MyFontSize().mediumTextSizeMobile
                              : MyFontSize().mediumTextSizeTablet),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: colorPrimary,
                        minimumSize: Size(Get.width, 40),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  flex: 1,
                ),
                const SizedBox(width: 10,),
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       var api  = ApiClient.methodPost(Api.logoutApi, {
                //         "user_id": SqliteDatabase.readData(StorageHelperKeys.USERID),
                //         "token": SqliteDatabase.readData(StorageHelperKeys.TOKEN)
                //       });
                //
                //       api.then((value){
                //         print("logout ${value}");
                //         if(Get.isDialogOpen!){
                //           Get.back();
                //         }
                //         Get.offAllNamed(Routes.loginScreen);
                //         SqliteDatabase.eraseData();
                //         showFlutterToast(strMsg: value['message']);
                //       }, onError: (error){
                //         throw error.toString();
                //       });
                //
                //     },
                //     child: Text(
                //       StringFile.logout,
                //       style: TextStyle(
                //           color: colorWhite,
                //          // fontFamily: Contants().FONT_KEY_NAME_AMAZON,
                //           fontSize: isMobile(context)
                //               ? MyFontSize().mediumTextSizeMobile
                //               : MyFontSize().mediumTextSizeTablet),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //         primary: colorPrimary,
                //         minimumSize: Size(Get.width, 40),
                //         shape: const RoundedRectangleBorder(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(10.0)))),
                //   ),
                //   flex: 1,
                // ),

              ],
            ),
          ),
          
        ],
      ),
    ));
  }

  //show snack bar
  static void showSnackBar({String title = "Alert!", required String strMsg}) {
    Get.snackbar(title, strMsg,
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showDialogWithAppBar(
      {String title = 'congobonarche™',
      String? description = 'Welcome to congobonmarche'}) {
    Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: Text(title),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            SizedBox(
              height: Get.mediaQuery.size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                description ?? '',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: Get.mediaQuery.size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                if (Get.isDialogOpen!) Get.back();
              },
              child: const Text('Ok'),
            ),
            SizedBox(
              height: Get.mediaQuery.size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  static void showNotificationAppBar(BuildContext context,
      {required bool darkMode,
      String title = 'ownUrHealth™',
      required String description,
      required String message}) {
    Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: colorPrimary,
              title: Text(
                title,
                style: TextStyle(
                    color: colorWhite,
                    fontSize: isMobile(context)
                        ? MyFontSize().mediumTextSizeMobile
                        : MyFontSize().mediumTextSizeTablet),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            Container(
              width: Get.width,
              color: darkMode ? colorPrimary : colorWhite,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.mediaQuery.size.height * 0.03,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        color: darkMode ? colorWhite : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: isMobile(context)
                            ? MyFontSize().normalTextSizeMobile
                            : MyFontSize().normalTextSizeTablet),
                  ),
                  SizedBox(
                    height: Get.mediaQuery.size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: darkMode ? colorWhite : Colors.black,
                          fontSize: isMobile(context)
                              ? MyFontSize().smallTextSizeMobile
                              : MyFontSize().smallTextSizeTablet),
                    ),
                  ),
                  SizedBox(
                    height: Get.mediaQuery.size.height * 0.03,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (Get.isDialogOpen!) Get.back();
                    },
                    child: const Text('Ok'),
                  ),
                  SizedBox(
                    height: Get.mediaQuery.size.height * 0.02,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CupertinoActivityIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Please Wait...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  //hide keybord

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // Url Launcher Method

  static void launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  static waitingDialog() {
    return const Center(
      child: CupertinoActivityIndicator(
        color: Colors.green,
        radius: 20,
      ),
    );
  }
}
