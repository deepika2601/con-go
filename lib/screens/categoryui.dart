import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/imagecard.dart';
import 'package:congobonmarche/utils/screen/loader.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryUIScreen extends StatelessWidget {
  final List<Categories> categories;
  final String type;
  final String searchString;
  const CategoryUIScreen(
      {Key? key,
      required this.categories,
      required this.type,
      required this.searchString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Categories> finalcategories = [];
    bool data = false;
    Future _itemcheck() async {
      finalcategories = [];

      for (int i = 0; i < categories.length; i++) {
        if (categories[i]
            .categoryName!
            .toLowerCase()
            .contains(searchString.toLowerCase())) {
          finalcategories.add(categories[i]);
        }
      }
      data = true;
      return finalcategories;
    }

    return FutureBuilder(
        future: _itemcheck(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (finalcategories.length == 0) {
              return Center(
                  child: Text(
                "Aucune donnée disponible",
                style: Style_File.title,
              ));
            } else {
              return GridView.builder(
                padding: EdgeInsets.only(
                    left: 2.w, right: 2.w, top: 2.w, bottom: 2.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2.8),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ImagesScreen(
                            url: finalcategories[index].mediaName.toString()),
                        Container(
                          height: 8.h,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.7),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Center(
                            child: Text(
                              finalcategories[index].categoryName ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontFamily: 'Amazon',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (type == "category") {
                        Navigator.pushNamed(
                          context,
                          Routes.subcategoryScreen,
                          arguments: {
                            StringFile.categoryId:
                                finalcategories[index].categoryId ?? '',
                            StringFile.categoryName:
                                finalcategories[index].categoryName ?? ''
                          },
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          Routes.subcategoryAdsScreen,
                          arguments: {
                            StringFile.subcategorysads:
                                finalcategories[index].categorySlug ?? '',
                          },
                        );
                      }

                      // Get.to(S);
                    },
                  );
                },
                itemCount: finalcategories.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              );
            }
          } else {
            return LoaderScreen();
          }
        });
  }
}
