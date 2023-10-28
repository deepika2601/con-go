// import 'package:congobonmarche/apis/network.dart';
// import 'package:dio/dio.dart';
// import '../db_helper/dialog_helper.dart';
// import 'api.dart';

// class ApiClient {
//   static Dio dio = Dio();
//   int total = 0;

//   static getHomeApi() async {
//     String path = '$HOME';
//     Options options = Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {Headers.acceptHeader: 'application/json'});
//     try {
//       Response response = await dio.get(path, options: options);
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       if (e.type == DioErrorType.receiveTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//     }
//   }

//   // category api

//   static getCategoryApi() async {
//     String path = '$CATEGORY';
//     Options options = Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {Headers.acceptHeader: 'application/json'});
//     try {
//       Response response = await dio.get(path, options: options);
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       if (e.type == DioErrorType.receiveTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//     }
//   }

//   // getSubCategoryApi
//   // print("object id $category_id");
//   // String path = '$SUBCATEGORY' + '/$category_id';   // change  '$SUBCATEGORY'  to '$SUBCATEGORY' + '/$category_id
//   // Options options = Options(
//   //     contentType: Headers.formUrlEncodedContentType,
//   //     headers: {Headers.acceptHeader: 'application/json'});
//   // try {
//   //   Response response = await dio.get(path, options: options); // change
//   //    print(response.data);
//   //    print(response.statusCode);

//   // Subcategory
//   // String category_id; // change int to String
//   // ApiClient.getSubCategoryApi(
//   // category_id: int.parse(
//   // category_id)), //change category_id to int.parse(category_id)
//   //

//   //subcategory
//   static getSubCategoryApi({required int category_id}) async {
//     print("object id $category_id");
//     String path = '$SUBCATEGORY' + '/$category_id';
//     Options options = Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {Headers.acceptHeader: 'application/json'});
//     try {
//       Response response = await dio.get(path, options: options); // change
//       print(response.data);
//       print(response.statusCode);
//       // if (response.statusCode == 200) {
//       //   return response.data;
//       // } else {
//       //   throw Exception('Authentication Error');
//       // }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       if (e.type == DioErrorType.receiveTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       //CustomFunctions.showToast('Error $e');
//     }
//   }

//   // ads approved
//   static getAdsApprovedApi() async {
//     String path = '$ADSAPPROVED' + '/2';
//     ServiceWithoutbody adsapproved = ServiceWithoutbody(path);
//     var data = await adsapproved.data();
//     return data['data'];

//     // Options options = Options(
//     //     contentType: Headers.formUrlEncodedContentType,
//     //     headers: {Headers.acceptHeader: 'application/json'});
//     // try {
//     //   print("object");
//     //   print(path);
//     //   Response response = await dio.get(path, options: options);
//     //   print(response);
//     //   print("object 1" + response.statusCode.toString());
//     //   if (response.statusCode == 200) {
//     //     return response.data;
//     //   } else {
//     //     throw Exception('Authentication Error');
//     //   }
//     // } on DioError catch (e) {
//     //   if (e.type == DioErrorType.connectTimeout) {
//     //     DialogHelper.hideLoading();
//     //     DialogHelper.showFlutterToast(
//     //         strMsg: 'Please Check Internet Connection');
//     //   }
//     //   if (e.type == DioErrorType.receiveTimeout) {
//     //     DialogHelper.hideLoading();
//     //     DialogHelper.showFlutterToast(
//     //         strMsg: 'Please Check Internet Connection');
//     //   }
//     // }
//   }

//   // ADS BOUTIQUES

//   static getAdsboutiquesApi() async {
//     // String path = '$ADSBOUTIQUES';
//     // Options options = Options(
//     //     contentType: Headers.formUrlEncodedContentType,
//     //     headers: {Headers.acceptHeader: 'application/json'});
//     String path = '$ADSBOUTIQUES';
//     ServiceWithoutbody adsboutiques = ServiceWithoutbody(path);
//     var data = await adsboutiques.data();
//     return data['data'];
//     // try {
//     //   Response response = await dio.get(path, options: options);
//     //   print(response);
//     //   if (response.statusCode == 200) {
//     //     return response.data;
//     //   } else {
//     //     throw Exception('Authentication Error');
//     //   }
//     // } on DioError catch (e) {
//     //   if (e.type == DioErrorType.connectTimeout) {
//     //     DialogHelper.hideLoading();
//     //     DialogHelper.showFlutterToast(
//     //         strMsg: 'Please Check Internet Connection');
//     //   }
//     //   if (e.type == DioErrorType.receiveTimeout) {
//     //     DialogHelper.hideLoading();
//     //     DialogHelper.showFlutterToast(
//     //         strMsg: 'Please Check Internet Connection');
//     //   }
//     // }
//   }

//   static loginApi({required String email, required String password}) async {
//     String path = '$LOGIN';
//     Options options = Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {Headers.acceptHeader: 'application/json'});
//     try {
//       var data = {"email": email, "password": password};
//       Response response = await dio.post(path, data: data, options: options);
//       if (response.statusCode == 200) {
//         print("login ${response.data}");
//         return response.data;
//       } else {
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       if (e.type == DioErrorType.receiveTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//     }
//   }

//   //ADSDETAILS

//   // static getAdsDetailsApi() async {
//   //   String path = '$ADSDETAILS';
//   //   Options options = Options(
//   //       contentType: Headers.formUrlEncodedContentType,
//   //       headers: {Headers.acceptHeader: 'application/json'});
//   //   try {
//   //     Response response = await dio.get(path, options: options);
//   //     if (response.statusCode == 200) {
//   //       return response.data;
//   //     } else {
//   //       throw Exception('Authentication Error');
//   //     }
//   //   } on DioError catch (e) {
//   //     if (e.type == DioErrorType.connectTimeout) {
//   //       DialogHelper.hideLoading();
//   //       DialogHelper.showFlutterToast(
//   //           strMsg: 'Please Check Internet Connection');
//   //     }
//   //     if (e.type == DioErrorType.receiveTimeout) {
//   //       DialogHelper.hideLoading();
//   //       DialogHelper.showFlutterToast(
//   //           strMsg: 'Please Check Internet Connection');
//   //     }
//   //   }
//   // }

//   static getAdsDetailsApi({required int id}) async {
//     String path = '$ADSDETAILS';
//     Options options = Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {Headers.acceptHeader: 'application/json'});

//     try {
//       var data = {
//         "id": id,
//       };
//       Response response = await dio.post(path, data: data, options: options);
//       if (response.statusCode == 200) {
//         // print("login ${response.data}");
//         return response.data;
//       } else {
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       if (e.type == DioErrorType.receiveTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//     }
//   }

//   // static ForgatePassword({
//   //   required String email,
//   // }) async {
//   //   String path = '$FORGOTPASSWORD';
//   //   Options options = Options(
//   //       contentType: Headers.formUrlEncodedContentType,
//   //       headers: {Headers.acceptHeader: 'application/json'});

//   //   try {
//   //     var data = {"email": email};
//   //     print(email);

//   //     Response response = await dio.post(path, data: data, options: options);
//   //     if (response.statusCode == 200) {
//   //       print("forget_password ${response.data}");
//   //       return response.data;
//   //     } else {
//   //       throw Exception('Authentication Error');
//   //     }
//   //   } on DioError catch (e) {
//   //     if (e.type == DioErrorType.connectTimeout) {
//   //       DialogHelper.hideLoading();
//   //       DialogHelper.showFlutterToast(
//   //           strMsg: 'Please Check Internet Connection');
//   //     }
//   //     if (e.type == DioErrorType.receiveTimeout) {
//   //       DialogHelper.hideLoading();
//   //       DialogHelper.showFlutterToast(
//   //           strMsg: 'Please Check Internet Connection');
//   //     }
//   //   }
//   // }

//   static getProfileUpdateApi() async {
//     String path = '$PROFILEUPDATE';
//     Options options = Options(
//         contentType: Headers.formUrlEncodedContentType,
//         headers: {Headers.acceptHeader: 'application/json'});
//     try {
//       Response response = await dio.get(path, options: options);
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (e) {
//       if (e.type == DioErrorType.connectTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//       if (e.type == DioErrorType.receiveTimeout) {
//         DialogHelper.hideLoading();
//         DialogHelper.showFlutterToast(
//             strMsg: 'Please Check Internet Connection');
//       }
//     }
//   }

//   static signUpApi({required}) {}
// }
