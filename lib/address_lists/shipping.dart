// ignore_for_file: unnecessary_this

import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/helper/data_helper.dart';
import 'package:congobonmarche/main.dart';

import 'package:congobonmarche/model/addresslistmodel.dart';
import 'package:congobonmarche/model/cityModel.dart';
import 'package:congobonmarche/model/countrylist.dart';
import 'package:congobonmarche/model/stateModel.dart';
import 'package:congobonmarche/provider/addressprovider.dart';
import 'package:congobonmarche/provider/categoriesprovider.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';

class Shipping extends StatefulWidget {
  final AddressList? addressdetails;
  const Shipping({Key? key, this.addressdetails}) : super(key: key);

  @override
  State<Shipping> createState() => _ShippingState();
}

class _ShippingState extends State<Shipping> {
  AddressProvider _categoriesProvider = AddressProvider();
  TextEditingController addressController = new TextEditingController();
  TextEditingController zipcodeController = new TextEditingController();
  TextEditingController fullname = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final
      // TextEditingController fullname = new TextEditingController();
      // TextEditingController fullname = new TextEditingController();
      // TextEditingController fullname = new TextEditingController();
      List<CountryListModel> getLanguages = <CountryListModel>[
    CountryListModel(0, 'Veuillez sélectionner le pays', 'CG'),
    CountryListModel(49, 'Congo', 'CG'),
    CountryListModel(50, 'Congo The Democratic Republic Of The', 'CD'),
  ];

  int countryid = 0;

  String? error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("object address");
    print(widget.addressdetails);

    _categoriesProvider = Provider.of<AddressProvider>(context, listen: false);
    if (widget.addressdetails != null) {
      fetchdata();
    }
  }

  Future<void> fetchdata() async {
    addressController.text = widget.addressdetails!.address ?? '';
    zipcodeController.text = widget.addressdetails!.zipcode ?? '';
    // for (int i = 0; i < getLanguages.length; i++) {
    //   if (getLanguages[i].id.toString() == widget.addressdetails!.countryId) {
    //     setState(() {
    //       countryid = i;
    //     });
    //   }
    // }
    for (int i = 0; i < getLanguages.length; i++) {
      if (getLanguages[i].id.toString() == widget.addressdetails!.countryId) {
        setState(() {
          countryid = i;
        });
        await _categoriesProvider.statelistdata(getLanguages[i].id.toString());
      }
    }

    if (_categoriesProvider.statelistmodel.isNotEmpty) {
      for (int i = 0; i < _categoriesProvider.statelistmodel.length; i++) {
        if (_categoriesProvider.statelistmodel[i].id.toString() ==
            widget.addressdetails!.stateId) {
          print("object check state");
          setState(() {
            _categoriesProvider.allstatelistindex = i;
            _categoriesProvider.allstatelistFetch = true;
          });
          await _categoriesProvider
              .citylistdata(widget.addressdetails!.stateId!);

          // statelistdata();
        }
      }
    } else {
      print(_categoriesProvider.statelistmodel);
      print("object no data");
    }
    if (_categoriesProvider.citylistmodel.isNotEmpty) {
      print("object city");
      for (int i = 0; i < _categoriesProvider.citylistmodel.length; i++) {
        print(_categoriesProvider.citylistmodel[i].id.toString());
        print(widget.addressdetails!.cityId);
        if (_categoriesProvider.citylistmodel[i].id.toString() ==
            widget.addressdetails!.cityId) {
          setState(() {
            _categoriesProvider.allcitylistindex = i;
            _categoriesProvider.allcitylistFetch = true;
          });
          // _categoriesProvider.statelistdata(getLanguages[i].id.toString());
          // statelistdata();
        }
      }
    }

    // await citylistdata();
    // for (int i = 0; i < _cityList.length; i++) {
    //   if (_cityList[i].id.toString() == widget.addressdetails!.cityId) {
    //     setState(() {
    //       cityid = i;
    //       cityfetch = true;
    //     });
    //   }
    // }
  }

  Future addresssave() async {
    var body = {
      "address": addressController.text,
      "zipcode": zipcodeController.text,
      "country_id": getLanguages[countryid].id.toString(),
      'state_id': _categoriesProvider.statelistmodel.isNotEmpty
          ? _categoriesProvider
              .statelistmodel[_categoriesProvider.allstatelistindex].id!
              .toString()
          : '0',
      'city_id': _categoriesProvider.citylistmodel.isNotEmpty
          ? _categoriesProvider
              .citylistmodel[_categoriesProvider.allcitylistindex].id!
              .toString()
          : '0',
      "user_id": MyApp.userid,
    };
    LoginApi registerresponse = LoginApi(body);
    final response = await registerresponse.address();
    print(response);
    if (response['status'] == "true") {
      Navigator.pop(context);
      DialogHelper.showFlutterToast(strMsg: response['message']);
    }
  }

  Future addressupdate() async {
    var body = {
      "address": addressController.text,
      "zipcode": zipcodeController.text,
      "country_id": getLanguages[countryid].id.toString(),
      'state_id': _categoriesProvider.statelistmodel.isNotEmpty
          ? _categoriesProvider
              .statelistmodel[_categoriesProvider.allstatelistindex].id!
              .toString()
          : '0',
      'city_id': _categoriesProvider.citylistmodel.isNotEmpty
          ? _categoriesProvider
              .citylistmodel[_categoriesProvider.allcitylistindex].id!
              .toString()
          : '0',
      "user_id": MyApp.userid,
      "id": widget.addressdetails!.id.toString()
    };
    LoginApi registerresponse = LoginApi(body);
    final response = await registerresponse.addressupdate();
    print(response);
    if (response['status'] == "true") {
      Navigator.pop(context);
      DialogHelper.showFlutterToast(strMsg: response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          "Adresse de livraison",
          style: TextStyle(
            color: colorWhite,
            // fontFamily: Contants().FONT_KEY_NAME_AMAZON,
            fontSize: isMobile(context)
                ? MyFontSize().mediumTextSizeMobile
                : MyFontSize().mediumTextSizeTablet,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body:
          Consumer<AddressProvider>(builder: (context, addressProvider, child) {
        return Padding(
          padding: EdgeInsets.all(2.h),
          child: Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(
                height: 5.h,
              ),
              Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: TextFormField(
                      controller: addressController,
                      validator: AppValidator.emptyValidator,
                      decoration: InputDecoration(
                        hintText: " Ligne d'adresse",
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      style: Style_File.subtitle
                          .copyWith(color: Colors.black, fontSize: 15.sp),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 5.h,
                    child: Container(
                      //  width: 100.h,
                      padding: EdgeInsets.all(3.w),

                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(1.w),
                          border: Border.all(color: colorBlack)),

                      // decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Colors.black,
                      //     ),
                      //     borderRadius: BorderRadius.circular(2.w)),
                      child: DropdownButton(
                        underline: SizedBox(),
                        value: getLanguages[countryid].id.toString(),
                        style: Style_File.subtitle
                            .copyWith(color: Colors.black, fontSize: 14.sp),
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
                              addressProvider
                                  .statelistdata(getLanguages[i].id.toString());
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
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
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                print(val);
                                // setState(() {
                                //   _countryname = int.parse(val.toString());
                                // });
                                for (int i = 0;
                                    i < addressProvider.statelistmodel.length;
                                    i++) {
                                  if (addressProvider.statelistmodel[i].id
                                          .toString() ==
                                      val.toString()) {
                                    setState(() {
                                      addressProvider.allstatelistindex = i;
                                      addressProvider.allcitylistFetch = false;
                                      addressProvider.allcitylistindex = 0;
                                      // statefetch = false;
                                      // stateid = 0;
                                      // cityfetch = false;
                                      // cityid = 0;
                                    });
                                    // statelistdata();
                                    addressProvider.citylistdata(addressProvider
                                        .statelistmodel[i].id
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
                              labelText: 'choisissez une Marque',
                              labelStyle: Style_File.subtitle.copyWith(
                                  color: Colors.black, fontSize: 14.sp),

                              //hintText: ' choisissez une catégorie',
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
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
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                print(val);
                                // setState(() {
                                //   _countryname = int.parse(val.toString());
                                // });
                                for (int i = 0;
                                    i < addressProvider.citylistmodel.length;
                                    i++) {
                                  if (addressProvider.citylistmodel[i].id
                                          .toString() ==
                                      val.toString()) {
                                    setState(() {
                                      addressProvider.allcitylistindex = i;
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
                              labelText: 'choisissez une Marque',
                              labelStyle: Style_File.subtitle.copyWith(
                                  color: Colors.black, fontSize: 14.sp),

                              //hintText: ' choisissez une catégorie',
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: TextFormField(
                      controller: zipcodeController,
                      keyboardType: TextInputType.number,
                      validator: AppValidator.emptyValidator,
                      decoration: InputDecoration(
                        hintText: "Code postal ",
                        hintStyle: TextStyle(
                          fontSize: 15.sp,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      style: Style_File.subtitle
                          .copyWith(color: Colors.black, fontSize: 15.sp),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 90.w,
                        height: 4.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (countryid > 0) {
                                if (_categoriesProvider.allcitylistindex > 0) {
                                  if (_categoriesProvider.allstatelistindex >
                                      0) {
                                    if (widget.addressdetails!.id != null) {
                                      addressupdate();
                                    } else {
                                      addresssave();
                                    }
                                  } else {
                                    DialogHelper.showFlutterToast(
                                        strMsg: "Veuillez sélectionner l'état");
                                    setState(() {
                                      error = "Veuillez sélectionner l'état";
                                    });
                                  }
                                } else {
                                  DialogHelper.showFlutterToast(
                                      strMsg: "Veuillez sélectionner la ville");
                                  setState(() {
                                    error = "Veuillez sélectionner la ville";
                                  });
                                }
                              } else {
                                DialogHelper.showFlutterToast(
                                    strMsg: "veuillez sélectionner le pays");
                                setState(() {
                                  error = "veuillez sélectionner le pays";
                                });
                              }
                            }
                          },
                          child: Text(
                            "Continuer",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontFamily: 'Amazon'),
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                colorPrimary,
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      side: BorderSide(
                                        color: colorPrimary,
                                      )))),
                        ),
                      ),
                    ],
                  ),
                ]),
              )
            ])),
          ),
        );
      }),
    );
  }
}
