import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/screens/adsapproved.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../apis/api.dart';
import '../model/adsapprovedModel.dart';
import '../utils/colors.dart';

class AdsapprovedUI extends StatelessWidget {
  List<AdsapprovedData> alladsapproveddata;
  final Function callback;
  final String type;
  final String searchString;

  AdsapprovedUI({
    Key? key,
    required this.alladsapproveddata,
    required this.type,
    required this.callback,
    required this.searchString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (alladsapproveddata.isEmpty) {
      return Text("data");
    }

    return ListView.builder(
      primary: true,
      itemCount: alladsapproveddata.length,
      itemBuilder: (context, i) {
        return alladsapproveddata[i]
                .title!
                .toLowerCase()
                .contains(searchString.toLowerCase())
            ? Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Container(
                  // color: Colors.red,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 10.h,
                        height: 12.h,
                        // child: Image.network(
                        //   imageurl + alladsapproveddata[i].mediaName.toString(),
                        //   fit: BoxFit.fill,
                        // ),
                        decoration: BoxDecoration(
                            // color: colorPrimary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.h)),
                            image: DecorationImage(
                                image: alladsapproveddata[i].media!.isNotEmpty
                                    ? NetworkImage(
                                        imageurl +
                                            alladsapproveddata[i]
                                                .media![0]
                                                .mediaName
                                                .toString(),
                                      )
                                    : AssetImage(StringFile.logo)
                                        as ImageProvider,
                                fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0, color: colorDark1lightGrey)
                            ]),
                      ),
                      Container(
                        width: 65.w,
                        height: 12.h,
                        padding:
                            EdgeInsets.only(left: 2.w, right: 2.w, top: 2.w),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0, color: colorDark1lightGrey)
                            ]),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    alladsapproveddata[i].title ?? '',
                                    maxLines: 2,
                                    // alladsapproveddata[i].title.toString(),

                                    style: Style_File.title
                                        .copyWith(fontSize: 15.sp),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushReplacementNamed(context, "/RegisterScreen");
                                  },
                                  child: Text(
                                      type == "pending"
                                          ? "(En attente)"
                                          : "(Approuvée)",
                                      style: Style_File.subtitle),
                                ),
                              ],
                            ),
                            // PAGE REDIRECT through gesture detector in text

                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image(
                                    image: AssetImage(
                                      "assets/images/map.png",
                                    ),
                                    width: 2.3.w,
                                    height: 2.3.h,
                                    fit: BoxFit.fill),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 4.0,
                                  ),
                                  child: SizedBox(
                                      child: Text(
                                          //"A123, Lorem Ipsum",
                                          alladsapproveddata[i]
                                              .address
                                              .toString(),
                                          style: Style_File.subtitle
                                          // style: TextStyle(
                                          //   fontFamily: 'Amazon',
                                          //   fontSize: 10,
                                          //   color: Colors.black54,
                                          // ),
                                          )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                              width: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image(
                                  image: AssetImage(
                                    "assets/images/inquiry.png",
                                  ),
                                  width: 2.3.w,
                                  height: 2.3.h,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Flexible(
                                  child: Text(
                                      alladsapproveddata[i].description ?? '',
                                      maxLines: 1,
                                      style: Style_File.subtitle),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 10.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                            color: colorPrimary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2.0, color: colorDark1lightGrey)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.createAds,
                                        arguments: {
                                          StringFile.adsapprovedData:
                                              alladsapproveddata[i],
                                        }).then((value) {
                                      callback("edit");
                                    });
                                  }, // Image tapped
                                  child: Image.asset(
                                    'assets/images/edit.png',
                                    fit: BoxFit.cover,
                                    color: Colors.white, // Fixes border issues
                                    width: 5.w,
                                    height: 5.w,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              color: Colors.white70,
                              height: 2,
                              thickness: 2,
                              indent: 8,
                              endIndent: 8,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title:
                                            Text('Boîte de dialogue Matériau'),
                                        content: Text(
                                            'Êtes-vous sûr de vouloir supprimer cette adresse'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                // _dismissDialog();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Close')),
                                          TextButton(
                                            onPressed: () {
                                              print('HelloWorld!');
                                              // _dismissDialog();
                                              callback(alladsapproveddata[i]
                                                  .id
                                                  .toString());
                                            },
                                            child: Text("D'accord"),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image: AssetImage(
                                        "assets/images/delete.png",
                                      ),
                                      width: 5.w,
                                      height: 5.w,
                                      color: Colors.white,
                                      fit: BoxFit.fill),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
