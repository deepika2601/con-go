import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/helper/data_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/provider/alladsprovider.dart';
import 'package:congobonmarche/screens/adsboutiquesui.dart';
import 'package:congobonmarche/screens/pop/homereport.dart';
import 'package:congobonmarche/screens/pop/homesentquery.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/loader.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import 'home.dart';
import 'package:flutter_share/flutter_share.dart';

class ProductDetails extends StatefulWidget {
  final String? adsid;
  final String? title;
  ProductDetails({Key? key, this.adsid, this.title}) : super(key: key);
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future<void> share(String title, String subtitle, String url) async {
    await FlutterShare.share(
        title: title, text: subtitle, linkUrl: url, chooserTitle: title);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AdsProvider>(context, listen: false)
        .adsdetailsdata(widget.adsid.toString());
    Provider.of<AdsProvider>(context, listen: false).premiumAdsdata();

    // _mainProvider.adsdetailsdata(widget.adsid.toString());
    // _mainProvider = Provider.of<AdsProvider>(context, listen: false);

    // _mainProvider.allAdsDetailsList.clear();
    print(widget.title);
  }

  int imageindex = 0;
  bool showsendQuery = false;
  bool showsendreport = false;
  String? adsid;
  @override
  Widget build(BuildContext context) {
    // AdsProvider _mainProvider =
    //     Provider.of<AdsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const HomeScreen()),
            // );
            Navigator.pop(context);
          },
          // onPressed: () {
          //   Navigator.pop(context);
          // },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        automaticallyImplyLeading: false,

        centerTitle: true,
        // elevation: 10,
        backgroundColor: const Color(0xffbf1f30),
      ),
      body: Consumer<AdsProvider>(
        builder: (context, adsProvider, child) {
          // print(adsProvider.allAdsDetailsLoading);
          // print(adsProvider.)
          // print(adsProvider.allAdsDetailsList);
          return adsProvider.allAdsDetailsLoading
              ? LoaderScreen()
              : adsProvider.allAdsDetailsList.isNotEmpty
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 1.h),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (adsProvider.allAdsDetailsList[0]
                                          .media!.isNotEmpty)
                                        Container(
                                          width: 90.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.w),
                                            image: DecorationImage(
                                                image: NetworkImage(imageurl +
                                                    adsProvider
                                                        .allAdsDetailsList[0]
                                                        .media![imageindex]
                                                        .mediaName!),
                                                fit: BoxFit.fill),
                                          ),
                                        )
                                      // SizedBox(
                                      //     width: 80.w,
                                      //     height: 50.h,
                                      //     child: Image.asset(
                                      //         'assets/images/ca7.jpg')),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  if (adsProvider
                                      .allAdsDetailsList[0].media!.isNotEmpty)
                                    Center(
                                      child: SizedBox(
                                          height: 10.h,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: adsProvider
                                                  .allAdsDetailsList[0]
                                                  .media!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        imageindex = index;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 20.w,
                                                      height: 20.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.w),
                                                        image: DecorationImage(
                                                            image: NetworkImage(imageurl +
                                                                adsProvider
                                                                    .allAdsDetailsList[
                                                                        0]
                                                                    .media![
                                                                        index]
                                                                    .mediaName!),
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })),
                                    ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(
                                  //             width: 65,
                                  //             height: 65,
                                  //             child: Image.asset(
                                  //                 'assets/images/ca7.jpg')),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(
                                  //             width: 65,
                                  //             height: 65,
                                  //             child: Image.asset(
                                  //                 'assets/images/ca7.jpg')),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         SizedBox(
                                  //             width: 65,
                                  //             height: 65,
                                  //             child: Image.asset(
                                  //                 'assets/images/ca7.jpg')),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            adsProvider
                                                .allAdsDetailsList[0].title
                                                .toString(),
                                            style: Style_File.detailstitle),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.folder,
                                            size: 25.0,
                                            color: colorPrimary,
                                          ),
                                          label: Text("Électronique |",
                                              style: Style_File.title)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                share(
                                                    adsProvider
                                                        .allAdsDetailsList[0]
                                                        .title!,
                                                    adsProvider
                                                        .allAdsDetailsList[0]
                                                        .title!,
                                                    adsProvider
                                                        .adsDetailsModel.url!);
                                              },
                                              icon: const Icon(
                                                Icons.share,
                                                size: 25.0,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "USD ${adsProvider.allAdsDetailsList[0].price}",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      fontFamily: 'Amazon',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    width: 10,
                                  ),

                                  Text("Informations générales",
                                      style: Style_File.title),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.money,
                                          size: 2.h,
                                          color: Color(0xffbf1f30),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Prix", style: Style_File.title),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            "USD ${adsProvider.allAdsDetailsList[0].price ?? ''}",
                                            textAlign: TextAlign.center,
                                            style: Style_File.detailsubtitle),
                                      ]),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 2.h,
                                          color: Color(0xffbf1f30),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Emplacement",
                                            style: Style_File.title),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                              adsProvider
                                                  .allAdsDetailsList[0].address
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: Style_File.detailsubtitle),
                                        ),
                                      ]),

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 2.h,
                                          color: Color(0xffbf1f30),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Condition",
                                            style: Style_File.title),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            adsProvider.allAdsDetailsList[0]
                                                .adCondition
                                                .toString(),
                                            style: Style_File.detailsubtitle),
                                      ]),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    height: 2.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('La description',
                                      style: Style_File.title),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    adsProvider.allAdsDetailsList[0].description
                                        .toString(),
                                    style: Style_File.detailsubtitle,
                                  ),

                                  SizedBox(
                                    height: 2.h,
                                  ),

                                  Text("Information du vendeur",
                                      style: Style_File.title),

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    height: 2.0,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),

                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     // Column(
                                  //     //   children: [
                                  //     //     SizedBox(
                                  //     //       height: 50,
                                  //     //       width: 50,
                                  //     //       child: ClipOval(
                                  //     //         child: Image.asset(
                                  //     //           'assets/images/cat1.png',
                                  //     //           fit: BoxFit.cover,
                                  //     //         ),
                                  //     //       ),
                                  //     //     ),
                                  //     //   ],
                                  //     // ),
                                  //     // Row(
                                  //     //   mainAxisAlignment:
                                  //     //       MainAxisAlignment.spaceEvenly,
                                  //     //   //crossAxisAlignment: CrossAxisAlignment.center,
                                  //     //   children: [
                                  //     //     GestureDetector(
                                  //     //       onTap: () {
                                  //     //         // Navigator.pushReplacementNamed(context, "/FilterScreen");
                                  //     //       }, // Image tapped
                                  //     //       child: Column(
                                  //     //         children: [
                                  //     //           SizedBox(
                                  //     //               width: 30.w,
                                  //     //               height: 3.h,
                                  //     //               child: ElevatedButton(
                                  //     //                   child: Text(
                                  //     //                     "Follow",
                                  //     //                     style: Style_File.subtitle
                                  //     //                         .copyWith(
                                  //     //                             color: Colors.black),
                                  //     //                   ),
                                  //     //                   style: ButtonStyle(
                                  //     //                       foregroundColor:
                                  //     //                           MaterialStateProperty
                                  //     //                               .all<Color>(
                                  //     //                                   Colors.white),
                                  //     //                       backgroundColor:
                                  //     //                           MaterialStateProperty
                                  //     //                               .all<Color>(
                                  //     //                         new Color(0xFFD6D6D6),
                                  //     //                       ),
                                  //     //                       shape: MaterialStateProperty.all<
                                  //     //                               RoundedRectangleBorder>(
                                  //     //                           const RoundedRectangleBorder(
                                  //     //                               borderRadius:
                                  //     //                                   BorderRadius.all(
                                  //     //                                       Radius
                                  //     //                                           .circular(
                                  //     //                                               5)),
                                  //     //                               side: BorderSide(
                                  //     //                                 color:
                                  //     //                                     Colors.grey,
                                  //     //                               )))),
                                  //     //                   onPressed: () => {})),
                                  //     //         ],
                                  //     //       ),
                                  //     //     ),
                                  //     //   ],
                                  //     // ),
                                  //   ],
                                  // ),

// add in information section

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          adsProvider.allAdsDetailsList[0]
                                                  .sellerName ??
                                              '',
                                          style: Style_File.title),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                          image: AssetImage(
                                            "assets/images/map.png",
                                          ),
                                          width: 2.h,
                                          height: 2.h,
                                          fit: BoxFit.fill),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          adsProvider.allAdsDetailsList[0]
                                                  .address ??
                                              '',
                                          // bottomlist[index].title ?? '',
                                          style: Style_File.subtitle
                                              .copyWith(fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Image(
                                  //         image: AssetImage(
                                  //           "assets/images/time.png",
                                  //         ),
                                  //         width: 2.h,
                                  //         height: 2.h,
                                  //         fit: BoxFit.fill),
                                  //     SizedBox(
                                  //       width: 2.w,
                                  //     ),
                                  //     Text(
                                  //       'Last Seen 1 minute ago',
                                  //       // _mainProvider.allAdsDetailsList[0].address ??
                                  //       //     '',
                                  //       // bottomlist[index].title ?? '',
                                  //       style: Style_File.subtitle
                                  //           .copyWith(fontSize: 16.sp),
                                  //     ),
                                  //   ],
                                  // ),

                                  const SizedBox(
                                    height: 15,
                                  ),

                                  SizedBox(
                                      width: 100.w,
                                      height: 4.h,
                                      child: ElevatedButton(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "xxxxxxxxxx",
                                              style: Style_File.subtitle
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            Text(
                                              "Cliquez pour afficher le numéro de téléphone",
                                              style: Style_File.subtitle
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xffd4d1d1),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    side: BorderSide(
                                                      color: Color(0xffd4d1d1),
                                                    )))),
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        Utils().makingPhoneCall(
                                                            adsProvider
                                                                .allAdsDetailsList[
                                                                    0]
                                                                .sellerPhone!);
                                                      },
                                                      icon: const Icon(
                                                        Icons.phone,
                                                        size: 16.0,
                                                        color: Colors.grey,
                                                      ),
                                                      label: Text(
                                                          adsProvider
                                                              .allAdsDetailsList[
                                                                  0]
                                                              .sellerPhone!,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Amazon'))),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'afficher le numéro de téléphone',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontFamily: 'Amazon',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'D ACCORD'),
                                                child: const Text(
                                                  'D ACCORD',
                                                  style: TextStyle(
                                                      color: Color(0xffbf1f30),
                                                      fontFamily: 'Amazon',
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  SizedBox(
                                      width: 100.w,
                                      height: 4.h,
                                      child: ElevatedButton(
                                        child: Text(
                                          "Répondre par email",
                                          style: Style_File.subtitle
                                              .copyWith(color: Colors.black),
                                        ),
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xffd4d1d1),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    side: BorderSide(
                                                      color: Color(0xffd4d1d1),
                                                    )))),
                                        onPressed: () {
                                          setState(() {
                                            adsid = adsProvider
                                                .allAdsDetailsList[0].id
                                                .toString();
                                            showsendQuery = true;
                                          });
                                        },
                                      )),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  SizedBox(
                                      width: 100.w,
                                      height: 4.h,
                                      child: ElevatedButton(
                                        child: Text(
                                          "Signaler cette annonce",
                                          style: Style_File.subtitle
                                              .copyWith(color: Colors.black),
                                        ),
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xffd4d1d1),
                                            ),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    side: BorderSide(
                                                      color: Color(0xffd4d1d1),
                                                    )))),
                                        onPressed: () {
                                          setState(() {
                                            if (MyApp.userid != null) {
                                              adsid = adsProvider
                                                  .allAdsDetailsList[0].id
                                                  .toString();
                                              showsendreport = true;
                                            } else {
                                              DialogHelper.showFlutterToast(
                                                  strMsg:
                                                      "Veuillez vous connecter avant de supprimer les publicités");
                                            }
                                          });
                                        },
                                      )),

                                  SizedBox(
                                    height: 5.h,
                                  ),

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  if (adsProvider.allAdsPermium.isNotEmpty)
                                    const Divider(
                                      thickness: 1.0,
                                      height: 2.0,
                                    ),
                                  if (adsProvider.allAdsPermium.isNotEmpty)
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  if (adsProvider.allAdsPermium.isNotEmpty)
                                    Text(
                                      "Nouvelles annonces premium",
                                      style: Style_File.title
                                          .copyWith(fontSize: 18.sp),
                                    ),
                                  SizedBox(
                                    height: 5,
                                    // width: 55,
                                  ),

                                  if (adsProvider.allAdsPermium.isNotEmpty)
                                    AdsBoutiquesUIScreen(
                                      alladsdata: adsProvider.allAdsPermium,
                                    ),

                                  const SizedBox(
                                    height: 15,
                                  ),
                                ]),
                          ),
                        ),
                        if (showsendQuery)
                          Container(
                            height: 100.h,
                            width: 100.w,
                            color: Colors.transparent,
                            child: HomesentqueryScreens(
                              adsid: adsid.toString(),
                              callback: (value) {
                                print(value);
                                setState(() {
                                  showsendQuery = false;
                                });
                              },
                            ),
                          ),
                        if (showsendreport)
                          Container(
                            height: 100.h,
                            width: 100.w,
                            color: Colors.transparent,
                            child: HomesentreportScreens(
                              adsid: adsid.toString(),
                              callback: (value) {
                                print(value);
                                setState(() {
                                  showsendreport = false;
                                });
                              },
                            ),
                          )
                      ],
                    )
                  : Center(child: Text("No data found"));
        },
      ),
    );
  }
}
