import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/model/alladsModel.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/screens/productdetails.dart';
import 'package:congobonmarche/utils/imagecard.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AdsBoutiquesUIScreen extends StatelessWidget {
  List<AllAdsModelData> alladsdata;
  AdsBoutiquesUIScreen({Key? key, required this.alladsdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.45),
      ),
      //  itemCount: snapshot.data.length,
      itemBuilder: (context, i) {
        //   itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            // Navigator.pushReplacementNamed(context, "/ProductDetails");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => ProductDetails(
            //           adsid: alladsdata[i].id.toString(),
            //           title: alladsdata[i].title)),
            // );
            print(alladsdata[i].title);
            Navigator.pushNamed(context, Routes.productDetails, arguments: {
              StringFile.adsid: alladsdata[i].id.toString(),
              StringFile.titles: alladsdata[i].title
            });
          },
          child: Container(
            // color: Colors.amber,
            width: Get.width,
            margin: EdgeInsets.fromLTRB(2.w, 1.w, 2.w, 1.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ImagesScreen(url: alladsdata[i].me.toString()),
                Container(
                  width: Get.width,
                  height: 13.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 6.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: alladsdata[i].media!.isNotEmpty
                            ? NetworkImage(
                                imageurl + alladsdata[i].media![0].mediaName!)
                            : AssetImage(
                                StringFile.logo,
                              ) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),

                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alladsdata[i].title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //snapshot.data[i].title ?? '',
                          style: Style_File.title,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          //  "Cars and Vehicles",
                          alladsdata[i].description ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Style_File.subtitle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                image: AssetImage(
                                  "assets/images/go.png",
                                ),
                                width: 2.h,
                                height: 2.h,
                                fit: BoxFit.fill),
                            Flexible(
                              child: Text(
                                alladsdata[i].address!,
                                textDirection: TextDirection.ltr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                // bottomlist[index].title ?? '',
                                style: Style_File.subtitle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                                image: AssetImage(
                                  "assets/images/time.png",
                                ),
                                width: 2.h,
                                height: 2.h,
                                fit: BoxFit.fill),
                            Text(
                              "  1 day ago",
                              //   bottomlist[index].title ?? '',
                              style: Style_File.subtitle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "USD ${alladsdata[i].price ?? ''}",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Amazon',
                              fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: alladsdata.length,
      //  itemCount: snapshot.data.length,
      shrinkWrap: true,
      //    physics: const BouncingScrollPhysics(),
      physics: const ScrollPhysics(),
    );
  }
}
