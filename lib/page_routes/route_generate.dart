import 'package:congobonmarche/auth/setpassword.dart';
import 'package:congobonmarche/model/addresslistmodel.dart';
import 'package:congobonmarche/model/adsapprovedModel.dart';
import 'package:congobonmarche/navigation_drawer_item/aboutpage.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/address_lists/location.dart';
import 'package:congobonmarche/provider/addressprovider.dart';
import 'package:congobonmarche/provider/adsapprovedprovider.dart';
import 'package:congobonmarche/provider/alladsprovider.dart';
import 'package:congobonmarche/provider/categoriesprovider.dart';
import 'package:congobonmarche/provider/mainprovider.dart';
import 'package:congobonmarche/provider/notificationprovider.dart';
import 'package:congobonmarche/provider/ourpackageprovider.dart';
import 'package:congobonmarche/provider/profileuserprovider.dart';
import 'package:congobonmarche/provider/subcategoriesprovider.dart';
import 'package:congobonmarche/screens/notificationScreen.dart';
import 'package:congobonmarche/screens/subcategory.dart';
import 'package:congobonmarche/screens/subcategorysads.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../address_lists/shipping.dart';
import '../auth/loginall.dart';
import '../navigation_drawer_item/information.dart';
import '../navigation_drawer_item/privacy_policy.dart';
import '../navigation_drawer_item/terms_and_condition.dart';
import '../screens/edit_profile_scree.dart';
import '../screens/helpnsupport.dart';
import '../screens/ourpackage.dart';
import '../screens/paymentdetails.dart';
import '../screens/productdetails.dart';
import '../screens/splash.dart';
import '../screens/CreateAds.dart';
import '../screens/account.dart';
import '../screens/adsapproved.dart';
import '../screens/adsboutiques.dart';
import '../screens/adspending.dart';
import '../screens/category.dart';
import '../screens/filter.dart';
import '../auth/forgetpassword.dart';
import '../screens/home.dart';
import '../auth/login.dart';
import '../screens/navigation.dart';
import '../auth/otpverify.dart';
import '../auth/registration.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    Widget widgetScreen;
    switch (settings.name) {
      case Routes.splashScreen:
        widgetScreen = SplashScreen();
        break;

      case Routes.loginAll:
        widgetScreen = LoginAll();
        break;

      case Routes.loginScreen:
        widgetScreen = LoginScreen();
        break;

      case Routes.registerScreen:
        widgetScreen = RegisterScreen();
        break;

      case Routes.forgetPassScreen:
        widgetScreen = ForgetPassScreen();
        break;

      case Routes.setPassScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = SetPassScreen(
          email: args[StringFile.email],
        );
        break;

      case Routes.otpVerify:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = OtpVerify(
          pagetype: args[StringFile.pagetype],
          email: args[StringFile.email],
        );
        break;

      case Routes.navigationScreen:
        widgetScreen = NavigationScreen();
        break;

      case Routes.homeScreen:
        widgetScreen = ChangeNotifierProvider<MainProvider>(
            create: (BuildContext context) => MainProvider(),
            child: HomeScreen());
        break;

      case Routes.accountScreen:
        widgetScreen = ChangeNotifierProvider<ProfileUserProvider>(
            create: (BuildContext context) => ProfileUserProvider(),
            child: AccountScreen());
        break;

      case Routes.filterScreen:
        widgetScreen = ChangeNotifierProvider<AddressProvider>(
            create: (BuildContext context) => AddressProvider(),
            child: FilterScreen());

        break;
      case Routes.subcategoryScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = ChangeNotifierProvider<SubCategoriesProvider>(
          create: (BuildContext context) => SubCategoriesProvider(),
          child: SubcategoryScreen(
            categoryName: args[StringFile.categoryName],
            category_id: args[StringFile.categoryId],
          ),
        );
        break;

      case Routes.categoryScreen:
        widgetScreen = ChangeNotifierProvider<CategoriesProvider>(
            create: (BuildContext context) => CategoriesProvider(),
            child: CategoryScreen());
        break;
      case Routes.subcategoryAdsScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = ChangeNotifierProvider<AdsProvider>.value(
            value: AdsProvider(),
            child: SubcategoryAdsScreen(
              subcategorysads: args[StringFile.subcategorysads],
            ));
        break;

      // case Routes.subcategoryScreen:
      //   widgetScreen =  SubcategoryScreen();
      //   break;

      case Routes.createAds:
        Map<String, dynamic> args = settings.arguments != null
            ? settings.arguments as Map<String, dynamic>
            : {"data": ""};
        widgetScreen = ChangeNotifierProvider<AddressProvider>(
            create: (BuildContext context) => AddressProvider(),
            child: CreateAds(
              adsapprovedData:
                  args[StringFile.adsapprovedData] ?? AdsapprovedData(),
            ));
        break;

      case Routes.adsPendingScreen:
        widgetScreen = ChangeNotifierProvider<AdsapprovedProvider>(
            create: (BuildContext context) => AdsapprovedProvider(),
            child: AdsPendingScreen());

        break;

      case Routes.adsApproved:
        widgetScreen = ChangeNotifierProvider<AdsapprovedProvider>(
            create: (BuildContext context) => AdsapprovedProvider(),
            child: AdsApproved());
        break;

      case Routes.adsBoutiques:
        widgetScreen = ChangeNotifierProvider<AdsProvider>.value(
            value: AdsProvider(), child: AdsBoutiques());
        break;

      case Routes.notifyScreen:
        widgetScreen = ChangeNotifierProvider<NotificationProvider>(
            create: (BuildContext context) => NotificationProvider(),
            child: NotificationScreen());
        break;

      case Routes.productDetails:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = ChangeNotifierProvider<AdsProvider>.value(
            value: AdsProvider(),
            child: ProductDetails(
              adsid: args['adsid'],
              title: args['title'],
            ));
        break;

      // case Routes.productDetails:
      //   widgetScreen = ProductDetails(id: id,);
      //   break;

      case Routes.editProfileScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        widgetScreen = EditProfileScreen(
          profileuserdata: args['profileuserdata'],
        );
        break;

      case Routes.helpSupport:
        widgetScreen = HelpSupport();
        break;

      case Routes.location:
        widgetScreen = ChangeNotifierProvider<AddressProvider>(
            create: (BuildContext context) => AddressProvider(),
            child: Location());
        break;

      case Routes.paymentDetails:
        widgetScreen = PaymentDetails();
        break;

      case Routes.information:
        widgetScreen = Information();
        break;

      case Routes.privacypolicy:
        widgetScreen = PrivacyPolicy();
        break;
      case Routes.termscondition:
        widgetScreen = TermsAndCondition();
        break;
      case Routes.about:
        widgetScreen = About();
        break;

      case Routes.shipping:
        Map<String, dynamic> args = settings.arguments != null
            ? settings.arguments as Map<String, dynamic>
            : {"data": ""};
        widgetScreen = ChangeNotifierProvider<AddressProvider>(
            create: (BuildContext context) => AddressProvider(),
            child: Shipping(
              addressdetails: args[StringFile.addressdetails] ?? AddressList(),
            ));
        break;

      case Routes.ourpackage:
        widgetScreen = ChangeNotifierProvider<OurPackageProvider>(
            create: (BuildContext context) => OurPackageProvider(),
            child: OurPackage());

        break;

      // case Routes.searchBar:
      //   widgetScreen = SearchBar();
      //   break;

      default:
        widgetScreen = SplashScreen();
    }
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => widgetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  }
}
