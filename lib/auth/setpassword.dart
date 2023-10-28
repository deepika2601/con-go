import 'dart:convert';
import 'dart:developer';

import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/auth/loginall.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api.dart';
import '../db_helper/dialog_helper.dart';

class SetPassScreen extends StatefulWidget {
  String? email;

  SetPassScreen({Key? key, this.email}) : super(key: key);

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  final _form = GlobalKey<FormState>();
  bool _isValid = false;

  late ScaffoldMessengerState scaffoldMessenger;

  bool isLoading = false;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscureText1 = true;
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 4.w, right: 4.w),
          child: SingleChildScrollView(
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
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: Text(
                    "DEFINIR UN NOUVEAU MOT DE PASSE",
                    style: Style_File.title.copyWith(color: colorPrimary),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormScreen(
                        textEditingController: _newPasswordController,
                        hinttext: "nouveau mot de passe",
                        icon: Icons.lock,
                        validator: AppValidator.passwordValidator,
                        suffixIcon: true,
                        obscure: _obscureText,
                        onPressed: _toggle,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormScreen(
                        textEditingController: _confirmpasswordController,
                        hinttext: "Confirmer le nouveau mot de passe",
                        icon: Icons.lock,
                        validator: AppValidator.passwordValidator,
                        suffixIcon: true,
                        obscure: _obscureText1,
                        onPressed: _toggle1,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 22,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (isLoading) {
                                    return;
                                  }

                                  resetPassword(
                                    _newPasswordController.text,
                                    _confirmpasswordController.text,
                                  );
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            side: BorderSide(
                                              color: colorPrimary,
                                            )))),
                                child: const Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    "Envoyer la demande",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Amazon'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45),
                      _isValid
                          ? const Text(
                              'Set Password Successfully!',
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Amazon',
                                fontSize: 15,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword(String newpassword, String confirmpassword) async {
    if (_form.currentState!.validate()) {
      if (newpassword == confirmpassword) {
        var data = {
          'password': newpassword,
          'confirm_password': confirmpassword,
          'email': widget.email,
        };

        LoginApi registerresponse = LoginApi(data);
        var response = await registerresponse.setpassword();
        print(response);

        setState(() {
          isLoading = false;
        });

        if (response['status'].toString() == 'true') {
          setState(() {
            isLoading = false;
          });
          DialogHelper.showFlutterToast(
              strMsg: "Utilisateur Nouveau mot de passe mis à jour !!");
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          DialogHelper.showFlutterToast(
              strMsg: "Quelque chose s'est mal passé");
        }
      } else {
        setState(() {
          isLoading = false;
          DialogHelper.showFlutterToast(
              strMsg:
                  "Votre mot de passe et votre mot de passe de confirmation ne correspondent pas.");
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
