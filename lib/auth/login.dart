import 'dart:convert';
import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/auth/forgetpassword.dart';
import 'package:congobonmarche/auth/loginall.dart';
import 'package:congobonmarche/auth/otpverify.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/screens/home.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/loader.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/textform.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db_helper/dialog_helper.dart';
import '../page_routes/routes.dart';
import '../utils/string_file.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginScreen> {
  bool isLoading = false;
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _password = '';
  String _error = '';
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('login successfully');
      debugPrint(_userEmail);
      debugPrint(_password);
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoggedIn = false;
  Map _userObj = {};
  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print(account);
      setState(() {
        _currentUser = account;
        googlelogin(_currentUser);
      });
    });
    googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignIn.signIn();
      googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        print(account);
        setState(() {
          _currentUser = account;
        });
      });

      // _buildBody();
    } catch (error) {
      print(error);
    }
  }

  bool setvalue = false;
  bool valuedata = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 2.h,
              right: 2.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.h,
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
                      "S'IDENTIFIER",
                      style:
                          Style_File.detailstitle.copyWith(color: colorPrimary),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                        ],
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            child: Text("Mot de passe oublié?",
                                style: Style_File.subtitle
                                    .copyWith(color: Colors.black)),
                            onTap: () => {
                              // Get.offAndToNamed(Routes.forgetpassword);
                              Navigator.pushNamed(
                                  context, Routes.forgetPassScreen),
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ForgetPassScreen()),
                              // )
                            },
                          ),
                        ],
                      ),
                    ],
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
                          Navigator.pushNamed(context, Routes.termscondition);
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
                  Center(
                    child: Text(
                      _error,
                      style: Style_File.subtitle
                          .copyWith(color: Colors.red, fontSize: 15.sp),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _error = '';
                      });
                      // if (isLoading) {
                      //   return;
                      // }
                      // if (emailController.text.isEmpty ||
                      //     passwordController.text.isEmpty) {
                      //   DialogHelper.showFlutterToast(
                      //       strMsg: "Merci de compléter tous les champs");
                      //   setState(() {
                      //     isLoading = false;
                      //   });
                      //   return;
                      // }
                      login(emailController.text, passwordController.text);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
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
                              "connexion",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Amazon',
                              ),
                            )
                          : Container(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: colorWhite,
                              )),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Je n'ai pas de compte? ",
                            style: Style_File.subtitle),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerScreen);
                          },
                          child: Text("Créer un nouveau",
                              style: Style_File.subtitle
                                  .copyWith(color: colorPrimary)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("--- Ou connectez-vous avec ---",
                            style: Style_File.subtitle),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // InkWell(
                      //   onTap: () async {
                      //     if (_userObj.isNotEmpty) {
                      //       await FacebookAuth.instance.logOut().then((value) {
                      //         setState(() {
                      //           _isLoggedIn = false;
                      //           _userObj = {};
                      //         });
                      //       });
                      //     }
                      //     FacebookAuth.instance.login(permissions: [
                      //       "public_profile",
                      //       "email"
                      //     ]).then((value) {
                      //       FacebookAuth.instance
                      //           .getUserData()
                      //           .then((userData) {
                      //         setState(() {
                      //           _isLoggedIn = true;
                      //           _userObj = userData;
                      //           print(userData);
                      //           facebooklogin();
                      //         });
                      //       });
                      //     });
                      //   },
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 5.h,
                      //         width: 5.h,
                      //         child: Image.asset(
                      //           "assets/images/fb.png",
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(5.0),
                      //         child:
                      //             Text("facebook",  style: Style_File.subtitle
                      //     .copyWith(color: Colors.black)),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          if (_currentUser != null) {
                            _handleSignOut();
                          }
                          _handleSignIn();
                          // _buildBody();
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                              width: 5.h,
                              child: Image.asset(
                                "assets/images/goo.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Google",
                                  style: Style_File.subtitle
                                      .copyWith(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  googlelogin(GoogleSignInAccount? users) async {
    final GoogleSignInAccount? user = users;
    print(user);
    if (user != null) {
      var data = {
        'name': user.displayName,
        'email': user.email,
        'google_id': user.id,
      };
      print(data.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.fasebooklogin();
      print(response);
      print(response['error'] ==
          "Utilisateur déjà enregistré !! Veuillez vous connecter");
      if (response['status'] == 'true') {
        print("object data");
        Map<String, dynamic> res = response['data'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        MyApp.userid = res['id'].toString();
        MyApp.email_VALUE = res['email'].toString();
        // MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
        sharedPreferences.setString(StringFile.userid, res['id'].toString());
        sharedPreferences.setString(StringFile.email, res['email'].toString());
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homeScreen, (route) => false);
        // sharedPreferences.setString(
        //     StringFile.authtoken, response['token'].toString());
      } else {
        DialogHelper.showFlutterToast(strMsg: response['error']);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  login2(email, password) async {
    var data = {'email': email, 'password': password};
    print(data.toString());
    LoginApi registerresponse = LoginApi(data);
    final response = await registerresponse.login();
    if (response['status'].toString().toLowerCase() == "true") {
      Map<String, dynamic> res = response['data'];

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      MyApp.userid = res['id'].toString();
      MyApp.email_VALUE = res['email'].toString();
      MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
      sharedPreferences.setString(StringFile.userid, res['id'].toString());
      sharedPreferences.setString(StringFile.email, res['email'].toString());
      sharedPreferences.setString(
          StringFile.authtoken, response['token'].toString());

      String? token;
      try {
        token = (await FirebaseMessaging.instance.getToken())!;
        print(token);
      } catch (e) {
        print(e);
      }
      var bodydata = {'id': MyApp.userid, 'token': token};
      LoginApi fcmregisterresponse = LoginApi(bodydata);
      final responsefcm = await fcmregisterresponse.fcmlogin();
      print(responsefcm);
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
      DialogHelper.showFlutterToast(strMsg: "Connexion réussie");
    } else {
      setState(() {
        _error = response['error'].toString();
        isLoading = false;
      });
    }
  }

  facebooklogin() async {
    if (_userObj["email"] != null) {
      var data = {
        'name': _userObj["name"],
        'facebook_id': _userObj["id"],
        'email': _userObj["email"],
      };
      print(data.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.fasebooklogin();
      print(response);
      if (response['status'] == 'true') {
        Map<String, dynamic> res = response['data'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        MyApp.userid = res['id'].toString();
        MyApp.email_VALUE = res['email'].toString();
        // MyApp.AUTH_TOKEN_VALUE = response['token'].toString();
        sharedPreferences.setString(StringFile.userid, res['id'].toString());
        sharedPreferences.setString(StringFile.email, res['email'].toString());

        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homeScreen, (route) => false);
        // sharedPreferences.setString(
        //     StringFile.authtoken, response['token'].toString());
      } else {
        DialogHelper.showFlutterToast(strMsg: response['error']);
        setState(() {
          isLoading = false;
        });
      }
    } else {
      DialogHelper.showFlutterToast(
          strMsg:
              "Veuillez vous connecter à un autre compte avec un compte Facebook enregistré avec un identifiant de messagerie uniquement");
      setState(() {
        isLoading = false;
      });
    }
  }

  login(email, password) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      if (valuedata == true) {
        var data = {'email': email, 'password': password};
        print(data.toString());
        LoginApi registerresponse = LoginApi(data);
        final response = await registerresponse.login();
        if (response['status'].toString().toLowerCase() == "true") {
          Map<String, dynamic> res = response['data'];

          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          MyApp.userid = res['id'].toString();
          MyApp.email_VALUE = res['email'].toString();
          MyApp.AUTH_TOKEN_VALUE = response['token'].toString();

          sharedPreferences.setString(StringFile.userid, res['id'].toString());
          sharedPreferences.setString(
              StringFile.email, res['email'].toString());
          sharedPreferences.setString(
              StringFile.authtoken, response['token'].toString());

          String? token;
          try {
            token = (await FirebaseMessaging.instance.getToken())!;
            print(token);
          } catch (e) {
            print(e);
          }
          var bodydata = {'id': MyApp.userid, 'token': token};
          LoginApi fcmregisterresponse = LoginApi(bodydata);
          final responsefcm = await fcmregisterresponse.fcmlogin();
          print(responsefcm);
          setState(() {
            isLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeScreen, (route) => false);
          DialogHelper.showFlutterToast(strMsg: "Connexion réussie");
        } else {
          setState(() {
            _error = response['error'].toString();
            isLoading = false;
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
      setState(() {
        isLoading = false;
      });
    }
  }
}
