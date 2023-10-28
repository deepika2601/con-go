import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/auth/loginall.dart';
import 'package:congobonmarche/firebase_options.dart';
import 'package:congobonmarche/page_routes/route_generate.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/provider/addressprovider.dart';
import 'package:congobonmarche/provider/locdb.dart';
import 'package:congobonmarche/provider/mainprovider.dart';
import 'package:congobonmarche/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  return Utils().showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocDb().loginapp = await LocDb().isLoggedIn();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String? userid;
  static String? AUTH_TOKEN_VALUE;
  static String? email_VALUE;

  static logout() async {
    var data = {"id": userid};
    LoginApi registerresponse = LoginApi(data);
    await registerresponse.fcmlogout();
    googleSignIn.disconnect();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    userid = null;
    AUTH_TOKEN_VALUE = null;
    email_VALUE = null;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
            ChangeNotifierProvider<AddressProvider>(
                create: (_) => AddressProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splashScreen,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        );
      },
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//PTS code
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
