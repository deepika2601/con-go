import 'package:cached_network_image/cached_network_image.dart';
import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/provider/subcategoriesprovider.dart';
import 'package:congobonmarche/screens/categoryui.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import '../page_routes/routes.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';
import '../utils/text_widget.dart';
import 'adsboutiques.dart';
import 'home.dart';

class SubcategoryScreen extends StatefulWidget {
  // int category_id;
  final String categoryName;
  final String category_id;
  SubcategoryScreen({required this.category_id, required this.categoryName});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  SubCategoriesProvider _subCategoriesProvider = SubCategoriesProvider();
  bool searchshow = false;
  TextEditingController sercheditcontroler = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subCategoriesProvider =
        Provider.of<SubCategoriesProvider>(context, listen: false);
    _subCategoriesProvider.subCategorylist(widget.category_id);
  }

  String searchString = '';

  // change int to String
  @override
  Widget build(BuildContext context) {
    _subCategoriesProvider =
        Provider.of<SubCategoriesProvider>(context, listen: true);
    return Scaffold(
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
                      onChanged: ((value) {
                        setState(() {
                          searchString = sercheditcontroler.text;
                        });
                      }),
                      decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                searchshow = false;
                                sercheditcontroler.clear();
                                searchString = '';
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
                text: widget.categoryName,
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
          if (MyApp.userid != null)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.createAds);
              },
              icon: const Icon(Icons.add_circle_outlined),
            ),
        ],
        centerTitle: true,
        elevation: 10,
        backgroundColor: new Color(0xffbf1f30),
      ),

      body: Consumer<SubCategoriesProvider>(
        builder: ((context, value, child) {
          if (_subCategoriesProvider.subcategoriesList.isEmpty) {
            return LoaderScreen();
          }
          return CategoryUIScreen(
            categories: _subCategoriesProvider.subcategoriesList,
            type: "subcategory",
            searchString: searchString,
          );
        }),
      ),

//body section
      // body: SingleChildScrollView(
      //   child: SizedBox(
      //     width: Get.width,
      //     height: Get.height,
      //     child: FutureBuilder(
      //         future: ApiClient.getSubCategoryApi(
      //             category_id: int.parse(widget.category_id)),
      //         builder: (BuildContext context, AsyncSnapshot snapshot) {
      //           if (snapshot.connectionState == ConnectionState.done) {
      //             if (snapshot.hasData) {
      //               Map map = snapshot.data as Map;
      //               print('map');
      //               print(widget.category_id);
      //               List data = map['data']['sub_categories'];
      //               //  print(category_id);
      //               print(data);
      //               print('hello deep');

      //               GridView.builder(
      //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                   mainAxisSpacing: 5,
      //                   crossAxisSpacing: 5,
      //                   crossAxisCount: 2,
      //                   childAspectRatio: MediaQuery.of(context).size.width /
      //                       (MediaQuery.of(context).size.height / 1.7),
      //                 ),
      //                 itemBuilder: (BuildContext context, int index) {
      //                   return InkWell(
      //                     child: Stack(
      //                       children: <Widget>[
      //                         Container(
      //                           width: Get.width,
      //                           margin: const EdgeInsets.fromLTRB(5, 5, 5, 30),
      //                           child: Card(
      //                             elevation: 10,
      //                             color: colorPrimary,
      //                             // color: Colors.white,
      //                             child: Column(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               children: [
      //                                 Container(
      //                                   width: Get.width,
      //                                   child: Image.network(
      //                                     imageurl + data[index]['media_name'],
      //                                     height: 110,
      //                                     width: 600,
      //                                   ),
      //                                 ),
      //                                 Padding(
      //                                   padding: const EdgeInsets.all(15.0),
      //                                   child: Column(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.start,
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: [
      //                                       Text(
      //                                         data[index]['category_name'] ??
      //                                             '',
      //                                         style: const TextStyle(
      //                                             fontSize: 15,
      //                                             fontFamily: 'Amazon',
      //                                             color: Colors.white),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     // onTap: () {
      //                     //   Get.to(AdsBoutiques(
      //                     //     category_id: category_id,
      //                     //     sub_category_id: data[index]['id'],
      //                     //   ));
      //                     // },
      //                     onTap: () {
      //                       Navigator.pushReplacementNamed(
      //                           context, "/AdsBoutiques");
      //                     },
      //                   );
      //                 },
      //                 itemCount: data.length,
      //                 shrinkWrap: true,
      //                 // physics: const BouncingScrollPhysics(),
      //                 physics: const ScrollPhysics(),
      //               );
      //               // return Column( );
      //             }
      //           }
      //           return SizedBox(
      //             width: Get.width,
      //             height: Get.height,
      //             child: const Center(
      //               child: CircularProgressIndicator(
      //                 color: colorPrimary,
      //               ),
      //             ),
      //           );
      //         }),
      //   ),
      // ),
    );
  }
}
