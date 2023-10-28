import 'package:cached_network_image/cached_network_image.dart';
import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/model/mainmodel.dart';
import 'package:congobonmarche/provider/mainprovider.dart';
import 'package:congobonmarche/screens/pop/homeloginpop.dart';
import 'package:congobonmarche/screens/pop/homesentquery.dart';
import 'package:congobonmarche/screens/productdetails.dart';
import 'package:congobonmarche/screens/subcategory.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/menubar.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import '../page_routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initial Selected Value
  String dropdownvalue = 'Mes annonces';
  bool showloginpop = false;
  bool showsendQuery = false;
  String adsid = '';
  bool searchshow = false;
  String? Fq,
      Fmin,
      Fmax,
      Fcategoryid,
      Fsubcategoryid,
      Fbarendid,
      Fcountryid,
      Fstateid,
      Fcityid;
  // late MainProvider maindata;

  @override
  void initState() {
    // TODO: implement initState
    // MainProvider maindata =
    //     Provider.of<MainProvider>(context, listen: false);
    // maindata.categorylist();
    print(MyApp.email_VALUE);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Consumer<MainProvider>(builder: (context, maindata, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: searchshow
              ? Container(
                  // width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: maindata.searchController,
                        onChanged: ((value) {
                          maindata.fetchdata();
                        }),
                        decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  searchshow = false;
                                  maindata.isfilterNotifying = true;
                                  maindata.searchController.clear();
                                  maindata.fetchdata();
                                });
                              },
                            ),
                            hintText: 'recherchez...',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Amazon',
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                )
              : Container(),

          //  title: Text('Search'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('assets/images/navbar.png'),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          automaticallyImplyLeading: false,
          actions: [
            if (!searchshow)
              IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, Routes.filterScreen);
                  setState(() {
                    searchshow = true;
                  });
                },
                icon: Icon(Icons.search),
              ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.filterScreen).then((value) {
                  if (value != null) {
                    setState(() {
                      maindata.isfilterNotifying = false;
                    });
                    print(maindata.isfilterNotifying);
                  } else {
                    setState(() {
                      maindata.isfilterNotifying = true;
                    });
                    maindata.fetchdata();
                    print(maindata.isfilterNotifying);
                  }
                });
              },
              icon: Image.asset('assets/images/c7.png'),
            ),
            if (MyApp.userid != null)
              IconButton(
                onPressed: () async {
                  if (MyApp.userid == null) {
                    setState(() {
                      showloginpop = true;
                    });
                  } else {
                    Navigator.pushNamed(context, Routes.notifyScreen);
                  }

                  // String token;
                  // try {
                  //   token = (await FirebaseMessaging.instance.getToken())!;
                  //   print(token);
                  // } catch (e) {
                  //   print(e);
                  // }
                  // print("object check");
                },
                icon: const Icon(Icons.notifications_outlined),
              ),
          ],
          centerTitle: true,
          elevation: 10,
          backgroundColor: const Color(0xffbf1f30),
        ),
        // navigation drawer
        drawer: MenuBarScreens(),

//body section
        body: SizedBox(
            width: Get.width,
            height: Get.height,
            // API Call
            child: Stack(
              // alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: FutureBuilder(
                      future: maindata.isfilterNotifying
                          ? maindata.isNotifying
                              ? maindata.categorylist()
                              : maindata.serchcategorylist(
                                  maindata.searchController.text.trim())
                          : maindata.filtercategorylist(),
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            // FutureBuilder(
                            //     future: maindata.categorylist(),
                            //     builder: ((context, snapshot) {
                            //       return category_list(maindata.categoryList);
                            //     })),
                            SizedBox(
                              height: 1.h,
                            ),
                            category_list(maindata.categoryList),
                            if (maindata.categoryList.isNotEmpty)
                              if (maindata.isfilterNotifying)
                                SizedBox(
                                  // height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                          child: Text(
                                        "Récemment Annonces",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: colorPrimary,
                                        ),
                                      )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // Image(
                                      //     image: AssetImage(
                                      //       "assets/images/map.png",
                                      //     ),
                                      //     width: 25,
                                      //     height: 25,
                                      //     fit: BoxFit.fill),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.adsBoutiques);
                                        },
                                        child: Container(
                                          // height: 5.h,
                                          decoration: BoxDecoration(
                                              color: colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: colorPrimary)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.w, right: 2.w),
                                            child: Text(
                                              "Voir tout",
                                              style: Style_File.title.copyWith(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      )
                                    ],
                                  ),
                                ),
                            if (maindata.mainmodeldata.data?.ads != null)
                              SizedBox(
                                height: 1.h,
                              ),
                            // FutureBuilder(
                            //     future: maindata.addListener(),
                            //     builder: ((context, snapshot) {
                            //       return ads(maindata);
                            //     })),
                            ads(maindata),
                            SizedBox(
                              height: 5.h,
                            )
                          ],
                        );
                      }),
                ),
                if (showloginpop)
                  Container(
                    height: 100.h,
                    width: 100.w,
                    color: Colors.transparent,
                    child: HomeLoginPopScreens(
                      callback: (value) {
                        print(value);
                        setState(() {
                          showloginpop = false;
                        });
                      },
                    ),
                  ),
                if (showsendQuery)
                  Container(
                    height: 100.h,
                    width: 100.w,
                    color: Colors.transparent,
                    child: HomesentqueryScreens(
                      adsid: adsid,
                      callback: (value) {
                        print(value);
                        setState(() {
                          showsendQuery = false;
                        });
                      },
                    ),
                  )
              ],
            )),

        // floating action button

        floatingActionButton: (showloginpop || showsendQuery)
            ? Container()
            : FloatingActionButton.extended(
                onPressed: () {
                  if (MyApp.userid == null) {
                    setState(() {
                      showloginpop = true;
                    });
                  } else {
                    Navigator.pushNamed(context, Routes.createAds);
                  }
                },
                label: const Text('Vendez vos affaires'),
                icon: const Icon(Icons.add_circle_outlined),
                backgroundColor: colorPrimary,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget category_list(List<CategoryList>? categoryList) {
    if (categoryList == null || categoryList.isEmpty) {
      return Container();
    }
    // print(mainProvider.categoryList.length);
    return SizedBox(
      height: categoryList.length > 0 ? 12.h : 0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.subcategoryScreen,
                  arguments: {
                    StringFile.categoryId: categoryList[index].categoryId,
                    StringFile.categoryName: categoryList[index].categoryName
                  });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 4.w,
                    //  backgroundColor: data1[index]['color_class'] ?? '',
                    backgroundColor: colorPrimary,
                    // child: Padding(
                    //   padding: const EdgeInsets.all(2), // Border radius
                    //   child: ClipOval(
                    //     child: Image.network(
                    //       imageurl + categoryList[index].mediaName.toString(),
                    //     ),
                    //   ),
                    // ),
                    child: FaIcon(
                      categoryList[index].faIcon!.iconParse ??
                          FontAwesomeIcons.car,
                      color: Colors.white,
                      size: 2.h,
                    ),
                  ),
                  FittedBox(
                    child: SizedBox(
                      width: 20.w,
                      child: Padding(
                        padding: EdgeInsets.all(.5.w),
                        child: Text(
                          categoryList[index].categoryName ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'Amazon',
                              fontSize: 14.sp,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        shrinkWrap: true,
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget ads(MainProvider mainProvider) {
    if (mainProvider.mainmodeldata.data?.ads == null) {
      return SizedBox(
        width: Get.width,
        height: Get.height,
        child: const Center(
          child: CircularProgressIndicator(
            color: colorPrimary,
          ),
        ),
      );
    }
    if (mainProvider.ads.isEmpty) {
      return SizedBox(
        height: 90.h,
        width: 100.w,
        child: Center(
            child: Text(
          "Aucune donnée disponible",
          style: Style_File.title,
        )),
      );
    }
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 7.h),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8,
          crossAxisSpacing: 9,
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2.0),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: InkWell(
              onTap: () {
                // Get.to(ProductDetails(
                //   id: data[index]['id'],));
                Navigator.pushNamed(context, Routes.productDetails, arguments: {
                  'adsid': mainProvider.ads[index].id,
                  'title': mainProvider.ads[index].title
                }).then((value) {});
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ProductDetails(
                // adsid: mainProvider.ads[index].id,
                // title: mainProvider.ads[index].title)),
                // );
              },
              child: Container(
                // color: Colors.amber,
                margin: EdgeInsets.fromLTRB(2.w, 0, 2.w, 1.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 13.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: mainProvider.ads[index].media!.isNotEmpty
                                ? NetworkImage(imageurl +
                                    mainProvider
                                        .ads[index].media![0].mediaName!)
                                : AssetImage(
                                    StringFile.logo,
                                  ) as ImageProvider,
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5.0, color: colorDark1lightGrey)
                          ],
                          borderRadius: BorderRadius.circular(3.w)),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.phone,
                                          size: 16.0,
                                          color: Colors.grey,
                                        ),
                                        label: Text(
                                            mainProvider
                                                .ads[index].sellerPhone!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontFamily: 'Amazon'))),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  onPressed: () {
                                    Utils().makingPhoneCall(
                                        mainProvider.ads[index].sellerPhone!);
                                    Navigator.pop(context, 'D ACCORD');
                                  },
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
                          // child: Image.asset("assets/images/call.png",
                          //     width: 22, height: 22, fit: BoxFit.fill),
                          child: Icon(
                            Icons.call_outlined,
                            color: colorPrimary,
                          ),
                        ),
                        GestureDetector(
                          // onTap: () => showDialog<String>(
                          //   context: context,
                          //   builder: (BuildContextcontext) => AlertDialog(
                          //     actions: <Widget>[
                          //       IconButton(
                          //         icon: Image.asset(
                          //           'assets/images/close.png',
                          //         ),
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //         },
                          //       ),
                          //       const Divider(
                          //         thickness: 1,
                          //       ),

                          //     ],
                          //   ),
                          // ),
                          onTap: () {
                            setState(() {
                              adsid = mainProvider.ads[index].id.toString();
                              showsendQuery = true;
                            });
                          },
                          child: Icon(
                            Icons.chat,
                            color: colorPrimary,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: Text(
                        mainProvider.ads[index].title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Amazon',
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: .2.h,
                    ),
                    Text(
                      "USD ${mainProvider.ads[index].price} ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontFamily: 'Amazon',
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: mainProvider.ads.length,
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

extension IconStringExt on String {
  IconData? get iconParse => {
        "fa-tablet": FontAwesomeIcons.tablet,
        "fa-car": FontAwesomeIcons.car,
        "fa-bug": FontAwesomeIcons.bug,
        "fa-home": FontAwesomeIcons.home,
        'fa-area-chart': FontAwesomeIcons.chartArea,
        'fa-industry': FontAwesomeIcons.industry,
        'fa-leaf': FontAwesomeIcons.leaf,
        'fa-graduation-cap': FontAwesomeIcons.graduationCap,
        'fa-heartbeat': FontAwesomeIcons.heartbeat,
        'fa-map': FontAwesomeIcons.map,
      }[this];
}
