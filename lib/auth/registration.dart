import 'dart:convert';
import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/apis/network.dart';
import 'package:congobonmarche/auth/otpverify.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api.dart';
import '../db_helper/dialog_helper.dart';
import '../main.dart';
import '../page_routes/routes.dart';

class RegisterScreen extends StatefulWidget {
//  const RegisterScreen({Key? key}) : super(key: key);
  bool setvalue = false;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String name, email, password, phoneno;
  bool isLoading = false;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _userEmail = '';
  String _password = '';
  String _userMobile = '';
  String _error = '';
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Register successfully');
      debugPrint(_userName);
      debugPrint(_userEmail);
      debugPrint(_password);
      debugPrint(_userMobile);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool valuedata = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  signup(name, email, password, phone) async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confpasswordController.text) {
        if (valuedata == true) {
          var data = {
            'name': name,
            'email': email,
            'password': password,
            'mobile': phone,
          };
          LoginApi registerresponse = LoginApi(data);
          var response = await registerresponse.register();
          print(response);
          print(data.toString());
          if (response['status'].toString().toLowerCase() == "true") {
            Map<String, dynamic> user = response['data'];

            Navigator.pushNamed(context, Routes.otpVerify, arguments: {
              StringFile.pagetype: StringFile.signup,
              StringFile.email: email,
              StringFile.userid: user['id'].toString(),
            });

            setState(() {
              isLoading = false;
            });
          } else {
            DialogHelper.showFlutterToast(
                strMsg: "Échec de l'enregistremenkhjt!");

            setState(() {
              isLoading = false;
              _error = response['error'];
            });
          }
        } else {
          setState(() {
            _error = "Veuillez accepter les termes et conditions";
            isLoading = false;
          });
          DialogHelper.showFlutterToast(
              strMsg: "Veuillez accepter les termes et conditions");
        }
      } else {
        DialogHelper.showFlutterToast(
            strMsg:
                "Votre mot de passe et votre mot de passe de confirmation ne correspondent pas!");
        setState(() {
          isLoading = false;
          _error =
              'Votre mot de passe et votre mot de passe de confirmation ne correspondent pas!';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 4.h,
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

                  Center(
                    child: Text(
                      "ENREGISTREMENT",
                      style:
                          Style_File.detailstitle.copyWith(color: colorPrimary),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2.h,
                      right: 2.h,
                    ),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// username
                            TextFormScreen(
                              textEditingController: nameController,
                              hinttext: "Nom d'utilisateur",
                              icon: Icons.person,
                              validator: AppValidator.nameValidator,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormScreen(
                              textEditingController: emailController,
                              hinttext: "Identifiant de messagerie",
                              icon: Icons.email,
                              validator: AppValidator.emailValidator,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormScreen(
                              textEditingController: passwordController,
                              hinttext: "Mot de passe",
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
                              textEditingController: confpasswordController,
                              hinttext: "Confirmez le mot de passeb",
                              icon: Icons.lock,
                              validator: AppValidator.passwordValidator,
                              suffixIcon: true,
                              obscure: _obscureText1,
                              onPressed: _toggle1,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormScreen(
                              textEditingController: mobileController,
                              hinttext: "Téléphoner",
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: AppValidator.emptyValidator,
                            ),

                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: this.valuedata,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.valuedata = value!;
                                    });
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.termscondition);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "J'accepte les ",
                                        style: Style_File.subtitle,
                                      ),
                                      Text(
                                        "termes et conditions",
                                        style: Style_File.subtitle
                                            .copyWith(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _error,
                              style: Style_File.subtitle
                                  .copyWith(color: Colors.red, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _error = '';
                                });

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  signup(
                                      nameController.text.toString(),
                                      emailController.text.toString(),
                                      passwordController.text.toString(),
                                      mobileController.text.toString());
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: colorPrimary,
                                  borderRadius: BorderRadius.circular(20.h),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 20),
                                      blurRadius: 50,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                child: !isLoading
                                    ? Text(
                                        "SUIVANTE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Amazon',
                                        ),
                                      )
                                    : SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: colorWhite,
                                        )),
                              ),
                            ),
                          ],
                        )),
                  ),
                  // api call only working successfully

                  Container(
                    height: 25,
                    margin: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Déjà enregistré?", style: Style_File.subtitle),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginScreen);
                          },
                          child: Text(" S'identifier",
                              style: Style_File.subtitle
                                  .copyWith(color: colorPrimary)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            if (isLoading)
              Container(
                height: 100.h,
                width: 100.w,
                color: Colors.transparent,
              )
          ],
        ));
  }
}
