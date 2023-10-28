import 'package:congobonmarche/model/alladsModel.dart';
import 'package:congobonmarche/provider/alladsprovider.dart';
import 'package:congobonmarche/screens/adsboutiquesui.dart';
import 'package:congobonmarche/screens/adssubcategorylistui.dart';

import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/appbar.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import 'home.dart';

class SubcategoryAdsScreen extends StatefulWidget {
  final String subcategorysads;
  const SubcategoryAdsScreen({Key? key, required this.subcategorysads})
      : super(key: key);
  @override
  State<SubcategoryAdsScreen> createState() => _SubcategoryAdsScreenState();
}

class _SubcategoryAdsScreenState extends State<SubcategoryAdsScreen> {
  AdsProvider _addProvider = AdsProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.subcategorysads);
    _addProvider = Provider.of<AdsProvider>(context, listen: false);
    _addProvider.adssubcategoriesdata(widget.subcategorysads);
  }

  @override
  Widget build(BuildContext context) {
    _addProvider = Provider.of<AdsProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreen(title: 'Annonces(Boutiques)')),

//body section
      body: Consumer<AdsProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                if (_addProvider.adssubcategoriesModel.data == null)
                  SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: colorPrimary,
                      ),
                    ),
                  ),
                if (_addProvider.adssubcatgoriesFetch)
                  if (_addProvider.adsSubcategoriesList.isEmpty)
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Center(
                          child: Text(
                        "Aucune donnée disponible",
                        style: Style_File.title,
                      )),
                    ),
                if (_addProvider.adsSubcategoriesList.isNotEmpty)
                  AdsSubcategoryListUI(
                      alladsdata: _addProvider.adsSubcategoriesList),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget show(int? start, int? end, int? curentpage) {
    int? finalend = start! > 1001 ? end! - 5 : end;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = start; i <= finalend!; i++)
          Padding(
            padding: EdgeInsets.only(left: 1.w),
            child: InkWell(
              onTap: (() {
                _addProvider.allAdsdata(i.toString());
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
