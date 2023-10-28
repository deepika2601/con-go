import 'dart:convert';

import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/auth/otpverify.dart';
import 'package:congobonmarche/auth/setpassword.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../apis/api.dart';
import '../db_helper/dialog_helper.dart';

class ForgetPassScreen extends StatefulWidget {
  bool setvalue = false;

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _form = GlobalKey<FormState>();
  bool _isValid = false;
  String errror = '';

  void _saveForm() {
    setState(() {
      _isValid = _form.currentState!.validate();
    });
  }

  late ScaffoldMessengerState scaffoldMessenger;

  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 35.w,
                      width: 35.w,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'MOT DE PASSE OUBLIÉ',
                    style:
                        Style_File.detailstitle.copyWith(color: colorPrimary),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormScreen(
                          textEditingController: _emailController,
                          hinttext: "Identifiant de messagerie",
                          icon: Icons.email,
                          validator: AppValidator.emailValidator,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Veuillez saisir l'identifiant de messagerie ou le numéro de téléphone mobile. Nous vous enverrons un OTP par e-mail/SMS.",
                          style: Style_File.detailsubtitle,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          errror,
                          style: Style_File.subtitle
                              .copyWith(color: Colors.red, fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                errror = '';
                              });

                              if (isLoading) {
                                return;
                              }

                              forgotPassword(
                                _emailController.text.toString(),
                              );
                              // }
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  colorPrimary,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.h),
                                        side: BorderSide(
                                          color: colorPrimary,
                                        )))),
                            child: !isLoading
                                ? Text(
                                    "Envoyer la demande",
                                    style: Style_File.subtitle
                                        .copyWith(color: colorWhite),
                                  )
                                : SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: colorWhite,
                                    )),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Text(
                                            "N'oubliez pas votre mot de passe?",
                                            style: Style_File.detailsubtitle),
                                        onTap: () => {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: Text("S'IDENTIFIER",
                                        style: Style_File.detailsubtitle
                                            .copyWith(color: colorPrimary)),
                                    onTap: () => {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.loginScreen)
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              height: 100.h,
              width: 100.w,
              color: Colors.transparent,
            )
        ],
      ),
    );
  }

  forgotPassword(String email) async {
    setState(() {
      isLoading = true;
    });
    if (_form.currentState!.validate()) {
      var data = {
        'email': email,
      };
      print(email.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.forgetpassword();
      if (response['status'].toString() == "true") {
        Navigator.pushNamed(context, Routes.otpVerify, arguments: {
          StringFile.email: email,
          StringFile.pagetype: StringFile.forgot_password,
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => OtpVerify(
        //             email: email,
        //             pagetype: StringFile.forgot_password,
        //           )),
        // );
        setState(() {
          isLoading = false;
        });
      } else {
        errror = response['error'];
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
