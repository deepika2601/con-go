import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:congobonmarche/model/cityModel.dart';
import 'package:congobonmarche/model/countrylist.dart';
import 'package:congobonmarche/model/getBrandByCategoryIdModel.dart';
import 'package:congobonmarche/model/stateModel.dart';
import 'package:congobonmarche/provider/addressprovider.dart';
import 'package:congobonmarche/provider/mainprovider.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/appbar.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  AddressProvider _addressProvider = AddressProvider();
  MainProvider _mainProvider = MainProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController priceminController = new TextEditingController();
  TextEditingController pricemaxController = new TextEditingController();
  TextEditingController quController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressProvider = Provider.of<AddressProvider>(context, listen: false);
    _mainProvider = Provider.of<MainProvider>(context, listen: false);
    _addressProvider.allcategorieslistdata();
    fetchremove();
  }

  fetchremove() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("q", quController.text);
    sharedPreferences.setString("min", priceminController.text);
    sharedPreferences.setString("max", pricemaxController.text);
    sharedPreferences.setString("categoryId", '0');
    sharedPreferences.setString("allsubcategoriesid", '0');
    sharedPreferences.setString("allbrandid", '0');

    sharedPreferences.setString("countryid", "0");

    sharedPreferences.setString("statelist", '0');
    sharedPreferences.setString("citylist", '0');
  }

  List<CountryListModel> getLanguages = <CountryListModel>[
    CountryListModel(0, 'Veuillez sélectionner le pays', 'CG'),
    CountryListModel(49, 'Congo', 'CG'),
    CountryListModel(50, 'Congo The Democratic Republic Of The', 'CD'),
  ];
  int countryid = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarScreen(title: 'Filtrer les')),
        body: Consumer<AddressProvider>(
            builder: (context, addressProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 1.h,
                    ),
                    Text("Que recherchez-vous?",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Amazon')),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      //  padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: TextField(
                          controller: quController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Rechercher des mots-clés',
                            labelStyle: Style_File.subtitle
                                .copyWith(color: Colors.black, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Divider(
                      color: Colors.grey, //color of divider
                      height: 5, //height spacing of divider
                      thickness: 1, //thickness of divier line
                      indent: 1, //spacing at the start of divider
                      endIndent: 1, //spacing at the end of divider
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Catégorie',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Amazon',
                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Container(
                      // padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: addressProvider.allcategoriesFetch
                            ? Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(color: colorBlack)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: addressProvider
                                      .getalllistmodels[
                                          addressProvider.allcategoriesindex]
                                      .categoryId
                                      .toString(),
                                  style: Style_File.subtitle,
                                  isExpanded: true,
                                  // underline: SizedBox(),
                                  // icon: Icon(
                                  //   Icons.language,
                                  //   color: Colors.black,
                                  // ),
                                  items: addressProvider.getalllistmodels
                                      .map((Categories lang) {
                                    return new DropdownMenuItem<String>(
                                      value: lang.categoryId.toString(),
                                      child: Text(
                                        lang.categoryName.toString(),
                                        style: Style_File.subtitle.copyWith(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    print(val);
                                    // setState(() {
                                    //   _countryname = int.parse(val.toString());
                                    // });
                                    for (int i = 0;
                                        i <
                                            addressProvider
                                                .getalllistmodels.length;
                                        i++) {
                                      if (addressProvider
                                              .getalllistmodels[i].categoryId
                                              .toString() ==
                                          val.toString()) {
                                        setState(() {
                                          addressProvider.allcategoriesindex =
                                              i;
                                          addressProvider
                                              .allsubcategoriesindex = 0;
                                          addressProvider
                                              .allsubcategoriesFetch = false;
                                          addressProvider.allbrandindex = 0;
                                          addressProvider.allbrandFetch = false;
                                        });
                                        addressProvider.allsubcategoryistdata(
                                            addressProvider.getalllistmodels[i]
                                                .categoryId!);
                                        // statelistdata();
                                      }
                                    }
                                  },
                                ),
                              )
                            : TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'choisissez une catégorie',
                                  labelStyle: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),
                                  //hintText: ' choisissez une catégorie',
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Subcatégorie',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Amazon',
                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: addressProvider.allsubcategoriesFetch
                            ? Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(color: colorBlack)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: addressProvider
                                      .getsubcategorieslistmodels[
                                          addressProvider.allsubcategoriesindex]
                                      .id
                                      .toString(),
                                  style: Style_File.subtitle,
                                  isExpanded: true,
                                  // underline: SizedBox(),
                                  // icon: Icon(
                                  //   Icons.language,
                                  //   color: Colors.black,
                                  // ),
                                  items: addressProvider
                                      .getsubcategorieslistmodels
                                      .map((Categories lang) {
                                    return new DropdownMenuItem<String>(
                                      value: lang.id.toString(),
                                      child: Text(
                                        lang.categoryName.toString(),
                                        style: Style_File.subtitle.copyWith(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    print(val);
                                    // setState(() {
                                    //   _countryname = int.parse(val.toString());
                                    // });
                                    for (int i = 0;
                                        i <
                                            addressProvider
                                                .getsubcategorieslistmodels
                                                .length;
                                        i++) {
                                      if (addressProvider
                                              .getsubcategorieslistmodels[i].id
                                              .toString() ==
                                          val.toString()) {
                                        setState(() {
                                          addressProvider
                                              .allsubcategoriesindex = i;
                                          addressProvider.allbrandFetch = false;
                                          addressProvider.allbrandindex = 0;
                                        });
                                        addressProvider.allbrandlistdata(
                                            addressProvider
                                                .getsubcategorieslistmodels[i]
                                                .id
                                                .toString());
                                        // statelistdata();
                                      }
                                    }
                                  },
                                ),
                              )
                            : TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'choisissez une Marque',
                                  labelStyle: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),
                                  //hintText: ' choisissez une catégorie',
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Marque',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Amazon',
                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: addressProvider.allbrandFetch
                            ? Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(color: colorBlack)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: addressProvider
                                      .getbrandlistmodels[
                                          addressProvider.allbrandindex]
                                      .id
                                      .toString(),
                                  style: Style_File.subtitle,
                                  isExpanded: true,
                                  // underline: SizedBox(),
                                  // icon: Icon(
                                  //   Icons.language,
                                  //   color: Colors.black,
                                  // ),
                                  items: addressProvider.getbrandlistmodels
                                      .map((GetBrandModel lang) {
                                    return new DropdownMenuItem<String>(
                                      value: lang.id.toString(),
                                      child: Text(
                                        lang.brandName.toString(),
                                        style: Style_File.subtitle.copyWith(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    print(val);
                                    // setState(() {
                                    //   _countryname = int.parse(val.toString());
                                    // });

                                    for (int i = 0;
                                        i <
                                            addressProvider
                                                .getbrandlistmodels.length;
                                        i++) {
                                      if (addressProvider
                                              .getbrandlistmodels[i].id
                                              .toString() ==
                                          val.toString()) {
                                        setState(() {
                                          addressProvider.allbrandindex = i;
                                        });
                                        // statelistdata();
                                      }
                                    }
                                  },
                                ),
                              )
                            : TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'choisissez une Marque',
                                  labelStyle: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),

                                  //hintText: ' choisissez une catégorie',
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Pays',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Amazon',
                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Container(
                      //  padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius: BorderRadius.circular(1.w),
                              border: Border.all(color: colorBlack)),
                          child: DropdownButton(
                            underline: SizedBox(),
                            value: getLanguages[countryid].id.toString(),
                            style: Style_File.subtitle,
                            isExpanded: true,
                            // underline: SizedBox(),
                            // icon: Icon(
                            //   Icons.language,
                            //   color: Colors.black,
                            // ),
                            items: getLanguages.map((CountryListModel lang) {
                              return new DropdownMenuItem<String>(
                                value: lang.id.toString(),
                                child: Text(
                                  lang.name,
                                  style: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              print(val);
                              // setState(() {
                              //   _countryname = int.parse(val.toString());
                              // });
                              for (int i = 0; i < getLanguages.length; i++) {
                                if (getLanguages[i].id.toString() ==
                                    val.toString()) {
                                  setState(() {
                                    countryid = i;
                                    addressProvider.allstatelistFetch = false;
                                    addressProvider.allstatelistindex = 0;
                                    addressProvider.allcitylistFetch = false;
                                    addressProvider.allcitylistindex = 0;
                                    // statefetch = false;
                                    // stateid = 0;
                                    // cityfetch = false;
                                    // cityid = 0;
                                  });
                                  // statelistdata();
                                  addressProvider.statelistdata(
                                      getLanguages[i].id.toString());
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Région',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Amazon',
                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: addressProvider.allstatelistFetch
                            ? Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(color: colorBlack)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: addressProvider
                                      .statelistmodel[
                                          addressProvider.allstatelistindex]
                                      .id
                                      .toString(),
                                  style: Style_File.subtitle,
                                  isExpanded: true,
                                  // underline: SizedBox(),
                                  // icon: Icon(
                                  //   Icons.language,
                                  //   color: Colors.black,
                                  // ),
                                  items: addressProvider.statelistmodel
                                      .map((StatelistModel lang) {
                                    return new DropdownMenuItem<String>(
                                      value: lang.id.toString(),
                                      child: Text(
                                        lang.stateName.toString(),
                                        style: Style_File.subtitle.copyWith(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    print(val);
                                    // setState(() {
                                    //   _countryname = int.parse(val.toString());
                                    // });
                                    for (int i = 0;
                                        i <
                                            addressProvider
                                                .statelistmodel.length;
                                        i++) {
                                      if (addressProvider.statelistmodel[i].id
                                              .toString() ==
                                          val.toString()) {
                                        setState(() {
                                          addressProvider.allstatelistindex = i;
                                          addressProvider.allcitylistFetch =
                                              false;
                                          addressProvider.allcitylistindex = 0;
                                          // statefetch = false;
                                          // stateid = 0;
                                          // cityfetch = false;
                                          // cityid = 0;
                                        });
                                        // statelistdata();
                                        addressProvider.citylistdata(
                                            addressProvider.statelistmodel[i].id
                                                .toString());
                                      }
                                    }
                                  },
                                ),
                              )
                            : TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'choisissez une région',
                                  labelStyle: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),

                                  //hintText: ' choisissez une catégorie',
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Ville',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'Amazon',
                      ),
                    ),
                    SizedBox(
                      height: 0.2.h,
                    ),
                    Container(
                      //  padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 5.h,
                        child: addressProvider.allcitylistFetch
                            ? Container(
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                    color: colorWhite,
                                    borderRadius: BorderRadius.circular(1.w),
                                    border: Border.all(color: colorBlack)),
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  value: addressProvider
                                      .citylistmodel[
                                          addressProvider.allcitylistindex]
                                      .id
                                      .toString(),
                                  style: Style_File.subtitle,
                                  isExpanded: true,
                                  // underline: SizedBox(),
                                  // icon: Icon(
                                  //   Icons.language,
                                  //   color: Colors.black,
                                  // ),
                                  items: addressProvider.citylistmodel
                                      .map((CityListModel lang) {
                                    return new DropdownMenuItem<String>(
                                      value: lang.id.toString(),
                                      child: Text(
                                        lang.cityName.toString(),
                                        style: Style_File.subtitle.copyWith(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    print(val);
                                    // setState(() {
                                    //   _countryname = int.parse(val.toString());
                                    // });
                                    for (int i = 0;
                                        i <
                                            addressProvider
                                                .citylistmodel.length;
                                        i++) {
                                      if (addressProvider.citylistmodel[i].id
                                              .toString() ==
                                          val.toString()) {
                                        setState(() {
                                          addressProvider.allcitylistindex = 0;
                                          // statefetch = false;
                                          // stateid = 0;
                                          // cityfetch = false;
                                          // cityid = 0;
                                        });
                                        // statelistdata();

                                      }
                                    }
                                  },
                                ),
                              )
                            : TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFFFFFFF),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'choisissez une ville',
                                  labelStyle: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),

                                  //hintText: ' choisissez une catégorie',
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Divider(
                      color: Colors.grey, //color of divider
                      height: 5, //height spacing of divider
                      thickness: 1, //thickness of divier line
                      indent: 1, //spacing at the start of divider
                      endIndent: 1, //spacing at the end of divider
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text("Prix (Min-Max)",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Amazon')),
                    Padding(
                      padding: EdgeInsets.all(1.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.all(10),
                          //   child: SizedBox(
                          //     height: 5.h,
                          //     width: 16.h,
                          //     child: TextField(
                          //       controller: priceminController,
                          //       decoration: InputDecoration(
                          //         isDense: true,
                          //         border: OutlineInputBorder(),
                          //         labelText: 'Prix Min',
                          //         labelStyle: Style_File.subtitle.copyWith(
                          //             color: Colors.black, fontSize: 15.sp),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: 16.h,
                            child: TextFormField(
                              controller: priceminController,
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                labelText: 'Prix Min',
                                labelStyle: Style_File.subtitle.copyWith(
                                    color: Colors.black, fontSize: 15.sp),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 16.h,
                            child: TextFormField(
                              controller: pricemaxController,
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                labelText: 'Prix Max',
                                labelStyle: Style_File.subtitle.copyWith(
                                    color: Colors.black, fontSize: 15.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Divider(
                      color: Colors.grey, //color of divider
                      height: 5, //height spacing of divider
                      thickness: 1, //thickness of divier line
                      indent: 1, //spacing at the start of divider
                      endIndent: 1, //spacing at the end of divider
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: SizedBox(
                        height: 5.h,
                        width: 90.w,
                        child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString("q", quController.text);
                            sharedPreferences.setString(
                                "min", priceminController.text);
                            sharedPreferences.setString(
                                "max", pricemaxController.text);
                            sharedPreferences.setString(
                                "categoryId",
                                addressProvider.getalllistmodels.isNotEmpty
                                    ? _addressProvider
                                        .getalllistmodels[
                                            _addressProvider.allcategoriesindex]
                                        .categoryId!
                                        .toString()
                                    : '0');
                            sharedPreferences.setString(
                                "allsubcategoriesid",
                                _addressProvider
                                        .getsubcategorieslistmodels.isNotEmpty
                                    ? _addressProvider
                                        .getsubcategorieslistmodels[
                                            _addressProvider
                                                .allsubcategoriesindex]
                                        .id!
                                        .toString()
                                    : '0');
                            sharedPreferences.setString(
                                "allbrandid",
                                _addressProvider.getbrandlistmodels.isNotEmpty
                                    ? _addressProvider
                                        .getbrandlistmodels[
                                            _addressProvider.allbrandindex]
                                        .id!
                                        .toString()
                                    : '0');

                            sharedPreferences.setString("countryid",
                                getLanguages[countryid].id.toString());

                            sharedPreferences.setString(
                                "statelist",
                                _addressProvider.statelistmodel.isNotEmpty
                                    ? _addressProvider
                                        .statelistmodel[
                                            _addressProvider.allstatelistindex]
                                        .id!
                                        .toString()
                                    : '0');
                            sharedPreferences.setString(
                                "citylist",
                                _addressProvider.citylistmodel.isNotEmpty
                                    ? _addressProvider
                                        .citylistmodel[
                                            _addressProvider.allcitylistindex]
                                        .id!
                                        .toString()
                                    : '0');
                            // await _mainProvider.filtercategorylist(
                            //     quController.text,
                            //     priceminController.text,
                            //     pricemaxController.text,
                            //     addressProvider.getalllistmodels.isNotEmpty
                            //         ? _addressProvider
                            //             .getalllistmodels[
                            //                 _addressProvider.allcategoriesindex]
                            //             .categoryId!
                            //             .toString()
                            //         : '0',
                            //     _addressProvider.getsubcategorieslistmodels.isNotEmpty
                            //         ? _addressProvider
                            //             .getsubcategorieslistmodels[_addressProvider
                            //                 .allsubcategoriesindex]
                            //             .id!
                            //             .toString()
                            //         : '0',
                            //     _addressProvider.getbrandlistmodels.isNotEmpty
                            //         ? _addressProvider.getbrandlistmodels[_addressProvider.allbrandindex].id!
                            //             .toString()
                            //         : '0',
                            //     getLanguages[countryid].id.toString(),
                            //     _addressProvider.statelistmodel.isNotEmpty
                            //         ? _addressProvider
                            //             .statelistmodel[
                            //                 _addressProvider.allstatelistindex]
                            //             .id!
                            //             .toString()
                            //         : '0',
                            //     _addressProvider.citylistmodel.isNotEmpty
                            //         ? _addressProvider
                            //             .citylistmodel[_addressProvider.allcitylistindex]
                            //             .id!
                            //             .toString()
                            //         : '0');

                            Navigator.pop(context, "ok");
                          },
                          child: Wrap(
                            children: const <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20.0,
                              ),

                              Text(
                                "Filtrer les annonces",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Amazon'),
                              ),
                              // Text("Filtrer les annonces", style:TextStyle(fontSize:20)),
                            ],
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                colorPrimary,
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      side: BorderSide(
                                        color: colorPrimary,
                                      )))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Center(
                      child: SizedBox(
                        height: 5.h,
                        width: 90.w,
                        child: TextButton(
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text('Réinitialiser',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Amazon')),
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.grey,
                            onSurface: Colors.white,
                            side:
                                const BorderSide(color: Colors.grey, width: 2),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          onPressed: () {
                            print('Pressed');
                            setState(() {
                              quController.clear();
                              priceminController.clear();
                              pricemaxController.clear();
                              _addressProvider.allcategoriesindex = 0;
                              _addressProvider.allsubcategoriesindex = 0;
                              _addressProvider.allbrandindex = 0;
                              countryid = 0;
                              _addressProvider.allstatelistindex = 0;
                              _addressProvider.allcitylistindex = 0;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ]),
            ),
          );
        }));
  }
}
