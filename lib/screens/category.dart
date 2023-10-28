import 'package:cached_network_image/cached_network_image.dart';
import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/provider/categoriesprovider.dart';
import 'package:congobonmarche/provider/mainprovider.dart';
import 'package:congobonmarche/screens/categoryui.dart';
import 'package:congobonmarche/screens/subcategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import '../controller/category_controller.dart';
import '../page_routes/routes.dart';
import '../utils/colors.dart';
import '../utils/screen/appbar.dart';
import 'home.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoriesProvider _categoriesProvider = CategoriesProvider();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    _categoriesProvider.categorylist();
  }

  @override
  Widget build(BuildContext context) {
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: true);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreen(title: 'Catégorie')),

      body: Consumer<CategoriesProvider>(
        builder: ((context, value, child) {

          return _categoriesProvider.categoriesModel.data != null
              ? CategoryUIScreen(
                  categories: _categoriesProvider.categoriesList,
                  type: "category",
                  searchString: '',
                )
              : SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: colorPrimary,
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
