import 'dart:developer';

import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/provider/ourpackageprovider.dart';
import 'package:congobonmarche/screens/pop/homeloginpop.dart';
import 'package:congobonmarche/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/style_file.dart';

class OurPackage extends StatefulWidget {
  @override
  State<OurPackage> createState() => _OurPackageState();
}

class _OurPackageState extends State<OurPackage> {
  OurPackageProvider _packageProvider = OurPackageProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(MyApp.userid.toString());

    _packageProvider = Provider.of<OurPackageProvider>(context, listen: false);
    _packageProvider.ourpackagelist();
  }

  bool showpop = false;

  @override
  Widget build(BuildContext context) {
    _packageProvider = Provider.of<OurPackageProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notre Forfait"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.homeScreen, (route) => false);
          },

          //    onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color(0xffbf1f30),
      ),
      body: Consumer<OurPackageProvider>(
        builder: ((context, value, child) {
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              ListView.builder(
                itemCount: _packageProvider.ourpackageList.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: colorlightGrey,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Column(
                        children: [
                          Container(
                            height: 8.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2.w),
                                    topRight: Radius.circular(2.w))),
                            child: Center(
                              child: Text(
                                "PRIME",
                                style: Style_File.detailstitle
                                    .copyWith(color: colorWhite),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            _packageProvider.ourpackageList[i].name ?? '',
                            // "ADDITIONAL IMAGE PACK",
                            style: Style_File.detailstitle,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Stack(
                            fit: StackFit.loose,
                            clipBehavior: Clip.none,
                            children: [
                              Text(
                                _packageProvider.ourpackageList[i].cost ?? '',
                                //   "2.00",
                                style: Style_File.detailstitle
                                    .copyWith(fontSize: 5.h),
                              ),
                              Positioned(
                                top: -10,
                                left: -5.w,
                                child: Text(
                                  "\$",
                                  style: Style_File.subtitle
                                      .copyWith(fontSize: 4.h),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            ((_packageProvider.ourpackageList[i].description)
                                        ?.replaceAll('&eacute;', 'é'))
                                    ?.replaceAll(
                                        RegExp(r'<[^>]*>|&[^;]+;'), '') ??
                                '',
                            style: Style_File.title,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                              width: 80.w,
                              height: 5.h,
                              child: ElevatedButton(
                                  child: Text(
                                    "Acheter maintenant",
                                    style: Style_File.title
                                        .copyWith(color: colorWhite),
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        colorSecondry,
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              side: BorderSide(
                                                color: colorSecondry,
                                              )))),
                                  onPressed: () {
                                    // Navigator.pushReplacementNamed(
                                    //     context, )
                                    print("username is");
                                    print(MyApp.userid);
                                    if (MyApp.userid != "null") {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UsePaypal(
                                                  sandboxMode: false,
                                                  clientId:
                                                      "Acli5CRwDfgJzKQJlJhkqex_SnTV-phA5ZoUt4nJqRtMVZ5I_1BvwppMWmzDa5ZLEtZ4gPg-sLiixwa3",
                                                  secretKey:
                                                      "EM2ScncZGdCYGAUbKvcDv_DH9Bg_Q-yEIGekvRWpH_4dJDWwPGW_-exdrZ-gxrOxnouBVAGPWkNtLGxE",
                                                  returnURL:
                                                      "https://samplesite.com/return",
                                                  cancelURL:
                                                      "https://samplesite.com/cancel",
                                                  transactions: [
                                                    {
                                                      "amount": {
                                                        "total": "0.01",
                                                        "currency": "USD",
                                                        "details": {
                                                          "subtotal": "0.01",
                                                          "shipping": '0',
                                                          "shipping_discount": 0
                                                        }
                                                      },
                                                      "description":
                                                          "The payment transaction description.",
                                                      // "payment_options": {
                                                      //   "allowed_payment_method":
                                                      //       "INSTANT_FUNDING_SOURCE"
                                                      // },
                                                      "item_list": {
                                                        "items": [
                                                          {
                                                            "name": _packageProvider
                                                                .ourpackageList[
                                                                    i]
                                                                .name
                                                                .toString(),
                                                            "quantity": 1,
                                                            "price": "0.01",
                                                            "currency": "USD"
                                                          }
                                                        ],

                                                        // shipping address is not required though
                                                        // "shipping_address": {
                                                        //   "recipient_name":
                                                        //       "Jane Foster",
                                                        //   "line1":
                                                        //       "Travis County",
                                                        //   "line2": "",
                                                        //   "city": "Austin",
                                                        //   "country_code": "US",
                                                        //   "postal_code":
                                                        //       "73301",
                                                        //   "phone": "+00000000",
                                                        //   "state": "Texas"
                                                        // },
                                                      }
                                                    }
                                                  ],
                                                  note:
                                                      "Contact us for any questions on your order.",
                                                  onSuccess:
                                                      (Map params) async {
                                                    log("onSuccess: $params");
                                                    var body = {
                                                      "user_id": MyApp.userid,
                                                      "amount": _packageProvider
                                                          .ourpackageList[i]
                                                          .cost
                                                          .toString(),
                                                      "status": "success",
                                                      "currency": "USD",
                                                      "payer_email":
                                                          MyApp.email_VALUE,
                                                      "description": "",
                                                      "local_transaction_id":
                                                          params['paymentId']
                                                              .toString(),
                                                      "plan_id":
                                                          _packageProvider
                                                              .ourpackageList[i]
                                                              .id
                                                              .toString(),
                                                      "ad_id": ""
                                                    };

                                                    LoginApi payment =
                                                        LoginApi(body);
                                                    final response =
                                                        await payment
                                                            .paymentupdate();
                                                    print(response);
                                                  },
                                                  onError: (error) {
                                                    print("onError: $error");
                                                  },
                                                  onCancel: (params) {
                                                    print('cancelled: $params');
                                                  }),
                                        ),
                                      );
                                    } else {
                                      setState(() {
                                        showpop = true;
                                      });
                                    }
                                  })),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (showpop)
                Container(
                  height: 100.h,
                  width: 100.w,
                  color: Colors.transparent,
                  child: HomeLoginPopScreens(
                    callback: (value) {
                      print(value);
                      setState(() {
                        showpop = false;
                      });
                    },
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
