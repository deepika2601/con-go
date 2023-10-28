import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/provider/alladsprovider.dart';
import 'package:congobonmarche/screens/adsboutiquesui.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/appbar.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:congobonmarche/utils/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import 'home.dart';

class AdsBoutiques extends StatefulWidget {
  const AdsBoutiques({Key? key}) : super(key: key);
  @override
  State<AdsBoutiques> createState() => _AdsBoutiquesState();
}

class _AdsBoutiquesState extends State<AdsBoutiques> {
  AdsProvider _addProvider = AdsProvider();
  bool searchshow = false;
  TextEditingController sercheditcontroler = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AdsProvider>(context, listen: false).allAdsdata("1");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsProvider>(builder: (context, Adsprovider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          // appBar: PreferredSize(
          //     preferredSize: Size.fromHeight(50),
          //     child: AppBarScreen(title: 'Annonces(Boutiques)')),
          appBar: AppBar(
            title: searchshow
                ? Container(
                    width: double.infinity,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: sercheditcontroler,
                          onSubmitted: ((value) {
                            setState(() {
                              Adsprovider.allAdsdataserch(
                                  sercheditcontroler.text);
                              Adsprovider.allAdsSearch = true;
                            });
                          }),
                          // onChanged: ((value) {

                          // }),
                          decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  print("object ok");
                                  setState(() {
                                    searchshow = false;
                                    sercheditcontroler.clear();
                                    Adsprovider.allAdsdata("1");
                                    // searchString = '';
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
                : TextView(
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    font_size: 18.sp,
                    fontColor: Colors.white,
                    text: "Annonces(Boutique)",
                    textStyle: Theme.of(context).textTheme.bodyText1!,
                    softWrap: true,
                  ),
            // title: Text('SubCategory'),
            leading: InkWell(
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            actions: [
              if (!searchshow)
                IconButton(
                  onPressed: () {
                    setState(() {
                      searchshow = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
            ],
            centerTitle: true,
            elevation: 10,
            backgroundColor: new Color(0xffbf1f30),
          ),

//body section
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Container(
                  //  width: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 5,
                            width: 5,
                          ),
                          if (!Adsprovider.allAdsSearch)
                            Text(
                              "Toutes les annonces (${Adsprovider.allAdsModel.data?.total ?? ''})",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Amazon'),
                            ),
                          SizedBox(
                            height: 5,
                            // width: 55,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              if (Adsprovider.allAdsModel.data == null)
                SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: colorPrimary,
                    ),
                  ),
                ),
              if (Adsprovider.allAdsList != null)
                AdsBoutiquesUIScreen(alladsdata: Adsprovider.allAdsList),
              if (Adsprovider.allAdsList.isEmpty)
                Text(
                  "Aucune donnée disponible",
                  style: Style_File.title,
                ),
              if (!Adsprovider.allAdsSearch)
                if (Adsprovider.allAdsModel.data != null)
                  Container(
                    width: 90.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (() {
                              Adsprovider.allAdsdata(
                                  Adsprovider.allAdsModel.data!.currentPage! > 0
                                      ? (Adsprovider.allAdsModel.data!
                                                  .currentPage! -
                                              1)
                                          .toString()
                                      : Adsprovider
                                          .allAdsModel.data!.currentPage!
                                          .toString());
                            }),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 2.h,
                                  ),
                                  Text("PREV"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            child: show(
                                Adsprovider.allAdsModel.data!.from,
                                Adsprovider.allAdsModel.data!.to,
                                Adsprovider.allAdsModel.data!.currentPage,
                                Adsprovider),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          InkWell(
                            onTap: () {
                              Adsprovider.allAdsdata(
                                  Adsprovider.allAdsModel.data!.currentPage! > 0
                                      ? (Adsprovider.allAdsModel.data!
                                                  .currentPage! +
                                              1)
                                          .toString()
                                      : Adsprovider
                                          .allAdsModel.data!.currentPage!
                                          .toString());
                            },
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "NEXT",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.red,
                                    size: 2.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
              SizedBox(
                height: 2.h,
              )
            ],
          )));
    });
  }

  Widget show(int? start, int? end, int? curentpage, AdsProvider Adsprovider) {
    int? finalend = curentpage! > 1001 ? curentpage + 4 : curentpage + 9;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = curentpage; i <= finalend; i++)
          Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: InkWell(
              onTap: (() {
                Adsprovider.allAdsdata(i.toString());
              }),
              child: Text(
                i.toString(),
                style: TextStyle(
                    fontSize: 14.sp,
                    color: curentpage == i ? Colors.red : Colors.black),
              ),
            ),
          ),
      ],
    );
  }
}
