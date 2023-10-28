import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/auth/setpassword.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/screens/home.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerify extends StatefulWidget {
  final String? email;
  final String? userid;
  final String? pagetype;
  const OtpVerify({Key? key, this.email, this.pagetype, this.userid})
      : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  String _finalotp = '';
  String _error = '';

  Future<void> fetchdata() async {
    if (_finalotp.length == 6) {
      var data = {
        'email': widget.email,
        'otp': _finalotp,
      };
      LoginApi registerresponse = LoginApi(data);
      var response;
      print(widget.pagetype);
      print(StringFile.forgot_password);
      if (widget.pagetype == StringFile.forgot_password) {
        response = await registerresponse.forgetverifyOtp();
        print(response);
        print("object");
        print(data.toString());
        if (response['status'].toString().toLowerCase() == "true") {
          Navigator.pushNamed(context, Routes.setPassScreen, arguments: {
            StringFile.email: widget.email,
          });

          // DialogHelper.showFlutterToast(strMsg: "Otp Successful");
        } else {
          DialogHelper.showFlutterToast(strMsg: "mot de passe invalide!");
          print(response['error']);
          setState(() {
            _error = response['error'];
          });
        }
      } else {
        response = await registerresponse.verifyOtp();
        print(response);
        print(data.toString());
        if (response['status'].toString().toLowerCase() == "true") {
          print('Registration Successful');
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          MyApp.userid = widget.userid.toString();
          MyApp.email_VALUE = widget.email.toString();

          sharedPreferences.setString(
              StringFile.userid, widget.userid.toString());
          sharedPreferences.setString(
              StringFile.email, widget.email.toString());

          DialogHelper.showFlutterToast(strMsg: "inscription réussi!");
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeScreen, (route) => false);
        } else {
          DialogHelper.showFlutterToast(strMsg: "mot de passe invalide!");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 2.h, right: 2.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 3.h,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 35.w,
                    width: 35.w,
                  ),
                ),
                SizedBox(height: 2.h),
                Center(
                  child: Text(
                    'ENTREZ VOTRE OTP',
                    style:
                        Style_File.detailstitle.copyWith(color: colorPrimary),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: Text(
                    "Veuillez saisir l'identifiant de messagerie ou le numéro de téléphone mobile. Nous vous enverrons un OTP par e-mail/SMS.",
                    style: Style_File.detailsubtitle.copyWith(color: colorGrey),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),

                // PinCodeTextField(
                //   appContext: context,
                //   length: 6,
                //   obscureText: false,
                //   cursorColor: AppColors.colorBlack,
                //   animationType: AnimationType.fade,
                //   pastedTextStyle: TextStyle(
                //     color: AppColors.appPrimarycolor,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   pinTheme: PinTheme(
                //       shape: PinCodeFieldShape.box,
                //       disabledColor: AppColors.colorWhite,
                //       borderRadius: BorderRadius.circular(1.h),
                //       fieldHeight: 100.w / 8,
                //       fieldWidth: 100.w / 8,
                //       activeFillColor: AppColors.colorWhite,
                //       inactiveColor: AppColors.colorGrey,
                //       inactiveFillColor: AppColors.colorWhite,
                //       selectedFillColor: AppColors.colorWhite,
                //       selectedColor: AppColors.colorWhite,
                //       activeColor: AppColors.colorWhite),
                //   animationDuration: Duration(milliseconds: 300),
                //   enableActiveFill: true,
                //   onCompleted: (v) {
                //     print("Completed");
                //     _finalotp = v;
                //     print(_finalotp);
                //   },
                //   onChanged: (value) {
                //     print(value);
                //     setState(() {
                //       // currentText = value;
                //     });
                //   },
                //   beforeTextPaste: (text) {
                //     print("Allowing to paste $text");
                //     return true;
                //   },
                // ),

                PinCodeTextField(
                  keyboardType: TextInputType.phone,
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(1.h),
                    fieldHeight: 100.w / 8,
                    fieldWidth: 100.w / 8,
                    activeFillColor: Colors.grey,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.grey,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                    _finalotp = v;
                    print(_finalotp);
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      // currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  _error,
                  style: Style_File.subtitle
                      .copyWith(color: Colors.red, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                    width: 100.w,
                    height: 5.h,
                    child: ElevatedButton(
                        child: Text(
                          "Vérifier",
                          style: Style_File.title.copyWith(color: colorWhite),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              colorPrimary,
                            ),
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                        side: BorderSide(
                                          color: colorPrimary,
                                        )))),
                        onPressed: () {
                          setState(() {
                            _error = '';
                          });

                          fetchdata();
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
