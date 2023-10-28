import 'dart:convert';
import 'dart:io';

import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'login.dart';

import 'package:http/http.dart' as http;

GoogleSignIn googleSignIn = Platform.isIOS
    ? GoogleSignIn(
        // clientId:
        //     '271984837864-njs959jh42m4blc8q9ea6gcifik6f4e0.apps.googleusercontent.com',
        // Optional clientId
        // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
        clientId:
            '271984837864-geruo107erjvskjq2it2klvmeasm935q.apps.googleusercontent.com',
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      )
    : GoogleSignIn(
        // clientId:
        //     '271984837864-njs959jh42m4blc8q9ea6gcifik6f4e0.apps.googleusercontent.com',
        // Optional clientId
        // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',

        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

class LoginAll extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginAll> {
  bool _isLoggedIn = false;
  Map _userObj = {};
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    // _checkIfIsLogged();
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
    print("object sign");
    try {
      await googleSignIn.signIn();
      print(googleSignIn.onCurrentUserChanged);

      googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        print(account);
        print("object sign");
        setState(() {
          _currentUser = account;
          print(_currentUser);
        });
      });

      // _buildBody();
    } catch (error) {
      print(error);
    }
  }

  // Future<void> _checkIfIsLogged() async {
  //   final accessToken = await FacebookAuth.instance.acessToken;
  //   setState(() {
  //     _checking = false;
  //   });
  //   if (accessToken != null) {
  //     print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
  //     // now you can call to  FacebookAuth.instance.getUserData();
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _accessToken = accessToken;
  //     setState(() {
  //       _userData = userData;
  //     });
  //   }
  // }

  Future<void> _handleSignOut() => googleSignIn.disconnect();

  googlelogin(GoogleSignInAccount? users) async {
    final GoogleSignInAccount? user = await users;
    print("object user data");
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
      print(response['error'] == "User Already Registered!! Kindly Login");
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   child: _isLoggedIn
            //       ? Column(
            //           children: [
            //             Image.network(_userObj["picture"]["data"]["url"]),
            //             Text(_userObj["name"].toString()),
            //             Text(_userObj["email"].toString()),
            //             TextButton(
            //                 onPressed: () {
            //                   FacebookAuth.instance.logOut().then((value) {
            //                     setState(() {
            //                       _isLoggedIn = false;
            //                       _userObj = {};
            //                     });
            //                   });
            //                 },
            //                 child: Text("Logout"))
            //           ],
            //         )
            //       : Center(
            //           child: ElevatedButton(
            //             child: Text("Login with Facebook"),
            //             onPressed: () async {
            //               FacebookAuth.instance.login(permissions: [
            //                 'email',
            //                 'public_profile'
            //               ]).then((value) {
            //                 FacebookAuth.instance
            //                     .getUserData()
            //                     .then((userData) {
            //                   setState(() {
            //                     _isLoggedIn = true;
            //                     _userObj = userData;
            //                     print(userData);
            //                   });
            //                 });
            //               });
            //             },
            //           ),
            //         ),
            // ),
            SizedBox(
              height: 1.h,
            ),

            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),

            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 25.h,
                  width: 25.h,
                ),
              ),
            ),
            // SizedBox(
            //   height: 3.h,
            // ),
            // Center(
            //   child: Text(
            //     'CONNEXION / INSCRIPTION',
            //     style: TextStyle(
            //       color: colorPrimary,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 16.sp,
            //       fontFamily: 'Amazon',
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 3.h,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 30.0,
            //     right: 30.0,
            //   ),
            //   child: OutlinedButton(
            //       onPressed: () async {
            //         if (_userObj.isNotEmpty) {
            //           await FacebookAuth.instance.logOut().then((value) {
            //             setState(() {
            //               _isLoggedIn = false;
            //               _userObj = {};
            //             });
            //           });
            //         }
            //         // _login();

            //         FacebookAuth.instance.login().then((value) {
            //           FacebookAuth.instance.getUserData().then((userData) {
            //             setState(() {
            //               _isLoggedIn = true;
            //               _userObj = userData;
            //               print(userData);
            //               facebooklogin();
            //             });
            //           });
            //         });
            //       },
            //       child: Padding(
            //         padding: EdgeInsets.all(5.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Icon(
            //               Icons.facebook,
            //               color: Colors.blueAccent,
            //               size: 4.h,
            //             ),
            //             SizedBox(
            //               width: 1.h,
            //             ),
            //             Text(
            //               "Continuer avec Facebook",
            //               style: Style_File.logintext,
            //             ),
            //           ],
            //         ),
            //       ),
            //       style: ButtonStyle(
            //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(20.h),
            //                   side: BorderSide(color: Colors.red))))),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: OutlinedButton(
                  onPressed: () {
                    print("object");
                    if (_currentUser != null) {
                      print("object");
                      _handleSignOut();
                    }
                    _handleSignIn();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/google.png'),
                          fit: BoxFit.cover,
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        Text(
                          "Continuer avec Google",
                          style: Style_File.logintext,
                        ),
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                              side: BorderSide(color: Colors.red))))),
            ),
            SizedBox(
              height: 2.h,
            ),
            if (Platform.isIOS)
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                ),
                child: OutlinedButton(
                    onPressed: () async {
                      final credentials = await SignInWithApple.channel;

                      print(credentials);
                      final credential =
                          await SignInWithApple.getAppleIDCredential(scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ], state: 'state');

                      applelogin(credential.givenName ?? '',
                          credential.email ?? '', credential.userIdentifier!);
                      // } else {
                      //   DialogHelper.showFlutterToast(
                      //       strMsg:
                      //           "Veuillez vous connecter à un autre compte avec un compte Facebook enregistré avec un identifiant de messagerie uniquement");
                      // }

                      // final signInWithAppleEndpoint = Uri(
                      //   scheme: 'https',
                      //   host: 'flutter-sign-in-with-apple-example.glitch.me',
                      //   path: '/sign_in_with_apple',
                      //   queryParameters: <String, String>{
                      //     'code': credential.authorizationCode,
                      //     if (credential.givenName != null)
                      //       'firstName': credential.givenName!,
                      //     if (credential.familyName != null)
                      //       'lastName': credential.familyName!,
                      //     'useBundleId': (Platform.isIOS || Platform.isMacOS)
                      //         ? 'true'
                      //         : 'false',
                      //     if (credential.state != null)
                      //       'state': credential.state!,
                      //   },
                      // );

                      // final session = await http.Client().post(
                      //   signInWithAppleEndpoint,
                      // );

                      // // If we got this far, a session based on the Apple ID credential has been created in your system,
                      // // and you can now set this as the app's session
                      // // ignore: avoid_print
                      // print(session);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/Applelogo.png'),
                            fit: BoxFit.cover,
                            height: 4.h,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          Text(
                            "Continuer avec Apple",
                            style: Style_File.logintext,
                          ),
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.h),
                                    side: BorderSide(color: Colors.red))))),
              ),
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: Text(
                'OU UTILISEZ VOTRE COURRIEL',
                style: TextStyle(
                  color: colorPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  fontFamily: 'Amazon',
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.mail,
                          color: Colors.red,
                          size: 4.h,
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        Text(
                          "Continuer avec Email",
                          style: Style_File.logintext,
                        ),
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                              side: const BorderSide(color: Colors.red))))),
            ),

            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.registerScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.app_registration,
                          color: Colors.red,
                          size: 4.h,
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        Text(
                          "Inscrivez-vous maintenant",
                          style: Style_File.logintext,
                        ),
                      ],
                    ),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.h),
                              side: const BorderSide(color: Colors.red))))),
            ),
          ],
        ),
      ),
    );
  }

  // Future<AccessToken?> _login() async {
  //   final LoginResult result = await FacebookAuth.instance
  //       .login(); // by the fault we request the email and the public profile
  //   if (result.status == LoginStatus.success) {
  //     // get the user data
  //     // by default we get the userId, email,name and picture
  //     final userData = await FacebookAuth.instance.getUserData();

  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     print(userData);
  //     return result.accessToken;
  //   }

  //   print(result.status);
  //   print(result.message);
  //   return null;
  // }
  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  applelogin(String name, String email, String appleid) async {
    var data = {
      'name': name,
      'apple_id': appleid,
      'email': email,
    };
    print(data.toString());
    LoginApi registerresponse = LoginApi(data);
    final response = await registerresponse.fasebooklogin();
    print(response);
    if (response['status'] == 'true') {
      Map<String, dynamic> res = response['data'];
      print("object email ${res['email']}");
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
      }
    } else {
      DialogHelper.showFlutterToast(
          strMsg:
              "Veuillez vous connecter à un autre compte avec un compte Facebook enregistré avec un identifiant de messagerie uniquement");
    }
  }

  login(email, password) async {
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

      Navigator.pushNamedAndRemoveUntil(
          context, Routes.homeScreen, (route) => false);
      DialogHelper.showFlutterToast(strMsg: "Connexion réussie");
    }
  }
}
