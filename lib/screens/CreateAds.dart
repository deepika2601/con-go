import 'dart:convert';
import 'dart:io';

import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/model/adsapprovedModel.dart';
import 'package:congobonmarche/model/categoriesmodel.dart';
import 'package:congobonmarche/model/cityModel.dart';
import 'package:congobonmarche/model/countrylist.dart';
import 'package:congobonmarche/model/getBrandByCategoryIdModel.dart';
import 'package:congobonmarche/model/stateModel.dart';
import 'package:congobonmarche/provider/addressprovider.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/createformtext.dart';
import 'package:congobonmarche/utils/screen/appbar.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker/google_maps_place_picker.dart';
// import 'package:geocoder/geocoder.dart';

import '../utils/colors.dart';
import 'home.dart';

class CreateAds extends StatefulWidget {
  final AdsapprovedData? adsapprovedData;
  // static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  const CreateAds({
    Key? key,
    this.adsapprovedData,
  }) : super(key: key);

  @override
  State<CreateAds> createState() => _CreateAdsState();
}

class _CreateAdsState extends State<CreateAds> {
  AddressProvider _addressProvider = AddressProvider();
  String radioButtonItem = 'Particulier';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController addtitleController = new TextEditingController();
  TextEditingController latitudeController = new TextEditingController();
  TextEditingController longitudeController = new TextEditingController();
  TextEditingController adddescriptionController = new TextEditingController();
  TextEditingController conditionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController videourlController = new TextEditingController();
  TextEditingController sellernameController = new TextEditingController();
  TextEditingController selleremailController = new TextEditingController();
  TextEditingController sellerphoneController = new TextEditingController();
  TextEditingController selleraddressController = new TextEditingController();

  // Group Value for Radio Button.
  int id = 1;
  bool value = false;
  bool isChecked = false;
  // late PickResult selectedPlace;
  late String sitelocation, sitefinallocation;
  List<CountryListModel> getLanguages = <CountryListModel>[
    CountryListModel(0, 'Veuillez sélectionner le pays', 'CG'),
    CountryListModel(49, 'Congo', 'CG'),
    CountryListModel(50, 'Congo The Democratic Republic Of The', 'CD'),
  ];
  int countryid = 0;
  final ImagePicker picker = ImagePicker();
  String? filePath;

  File? imageFile;
  String? error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressProvider = Provider.of<AddressProvider>(context, listen: false);
    _addressProvider.allcategorieslistdata();
    print(widget.adsapprovedData);
    if (widget.adsapprovedData!.id != null) {
      fetchdata();
    }
  }

  //  getImageFromGallery() async {
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if(image != null){
  //     imageFile = File(image.path);
  //     filePath = image.path;
  //   }else{
  //     DialogHelper.showFlutterToast(strMsg: 'No File Selected');
  //   }

  // }
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List networkimage = [];

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
        for (int i = 0; i < imagefiles!.length; i++) {
          print(imagefiles![i].path);
        }
      } else {
        print("No image is selected.");
        DialogHelper.showFlutterToast(strMsg: 'Aucun fichier sélectionné');
      }
    } catch (e) {
      print("error while picking file.");
      DialogHelper.showFlutterToast(
          strMsg: 'erreur lors de la sélection du fichier.');
    }
  }

  Future fetchdata() async {
    addtitleController.text = widget.adsapprovedData!.title.toString();
    latitudeController.text =
        widget.adsapprovedData!.latitude.toString() != null
            ? widget.adsapprovedData!.latitude.toString()
            : '';
    longitudeController.text = widget.adsapprovedData!.longitude.toString();
    adddescriptionController.text = widget.adsapprovedData!.description!;
    conditionController.text = widget.adsapprovedData!.adCondition!;
    priceController.text = widget.adsapprovedData!.price!;
    videourlController.text = widget.adsapprovedData!.videoUrl.toString();
    sellernameController.text = widget.adsapprovedData!.sellerName!;
    selleremailController.text = widget.adsapprovedData!.sellerEmail!;
    sellerphoneController.text = widget.adsapprovedData!.sellerPhone!;
    selleraddressController.text = widget.adsapprovedData!.address!;
    for (int i = 0; i < widget.adsapprovedData!.media!.length; i++) {
      networkimage.add(widget.adsapprovedData!.media![i].mediaName);
    }
    await _addressProvider.allcategorieslistdata();
    if (_addressProvider.getalllistmodels.isNotEmpty) {
      for (int i = 0; i < _addressProvider.getalllistmodels.length; i++) {
        if (_addressProvider.getalllistmodels[i].categoryId.toString() ==
            widget.adsapprovedData!.categoryId) {
          print("object check state");
          setState(() {
            _addressProvider.allcategoriesindex = i;
            _addressProvider.allcategoriesFetch = true;
          });
          await _addressProvider
              .allsubcategoryistdata(widget.adsapprovedData!.categoryId!);

          // statelistdata();
        }
      }
    }

    if (_addressProvider.getsubcategorieslistmodels.isNotEmpty) {
      for (int i = 0;
          i < _addressProvider.getsubcategorieslistmodels.length;
          i++) {
        if (_addressProvider.getsubcategorieslistmodels[i].id.toString() ==
            widget.adsapprovedData!.subCategoryId) {
          print("object check state");
          setState(() {
            _addressProvider.allsubcategoriesindex = i;
            _addressProvider.allsubcategoriesFetch = true;
          });
          await _addressProvider
              .allbrandlistdata(widget.adsapprovedData!.subCategoryId!);

          // statelistdata();
        }
      }
    }
    if (_addressProvider.getbrandlistmodels.isNotEmpty) {
      for (int i = 0; i < _addressProvider.getbrandlistmodels.length; i++) {
        if (_addressProvider.getbrandlistmodels[i].id.toString() ==
            widget.adsapprovedData!.brandId) {
          print("object check state");
          setState(() {
            _addressProvider.allbrandindex = i;
            _addressProvider.allbrandFetch = true;
          });
          // await _addressProvider.allsubcategoryistdata(widget.adsapprovedData!.brandId!);

          // statelistdata();
        }
      }
    }
    for (int i = 0; i < getLanguages.length; i++) {
      if (getLanguages[i].id.toString() == widget.adsapprovedData!.countryId) {
        setState(() {
          countryid = i;
        });
        await _addressProvider.statelistdata(getLanguages[i].id.toString());
      }
    }

    if (_addressProvider.statelistmodel.isNotEmpty) {
      for (int i = 0; i < _addressProvider.statelistmodel.length; i++) {
        if (_addressProvider.statelistmodel[i].id.toString() ==
            widget.adsapprovedData!.stateId) {
          print("object check state");
          setState(() {
            _addressProvider.allstatelistindex = i;
            _addressProvider.allstatelistFetch = true;
          });
          await _addressProvider.citylistdata(widget.adsapprovedData!.stateId!);

          // statelistdata();
        }
      }
    }
    if (_addressProvider.citylistmodel.isNotEmpty) {
      for (int i = 0; i < _addressProvider.citylistmodel.length; i++) {
        if (_addressProvider.citylistmodel[i].id.toString() ==
            widget.adsapprovedData!.cityId) {
          setState(() {
            _addressProvider.allcitylistindex = i;
            _addressProvider.allcitylistFetch = true;
          });
          // _addressProvider.statelistdata(getLanguages[i].id.toString());
          // statelistdata();
        }
      }
    }
  }

  Future formadd() async {
    print("object");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_addressProvider.allcategoriesindex >= 0) {
        if (_addressProvider.allsubcategoriesindex > 0) {
          if (countryid > 0) {
            if (_addressProvider.allcitylistindex > 0) {
              if (_addressProvider.allstatelistindex > 0) {
                var body = {
                  'category_id': _addressProvider.getalllistmodels.isNotEmpty
                      ? _addressProvider
                          .getalllistmodels[_addressProvider.allcategoriesindex]
                          .categoryId!
                          .toString()
                      : '0',
                  'sub_category_id':
                      _addressProvider.getsubcategorieslistmodels.isNotEmpty
                          ? _addressProvider
                              .getsubcategorieslistmodels[
                                  _addressProvider.allsubcategoriesindex]
                              .id!
                              .toString()
                          : '0',
                  'brand_id': _addressProvider.getbrandlistmodels.isNotEmpty
                      ? _addressProvider
                          .getbrandlistmodels[_addressProvider.allbrandindex]
                          .id!
                          .toString()
                      : '0',
                  'title': addtitleController.text,
                  'latitude': latitudeController.text,
                  'longitude': longitudeController.text,
                  'description': adddescriptionController.text,
                  'type': radioButtonItem,
                  'price': priceController.text,
                  'video_url': videourlController.text,
                  'country_id': getLanguages[countryid].id.toString(),
                  'ad_condition': conditionController.text,
                  'state_id': _addressProvider.statelistmodel.isNotEmpty
                      ? _addressProvider
                          .statelistmodel[_addressProvider.allstatelistindex]
                          .id!
                          .toString()
                      : '0',
                  'city_id': _addressProvider.citylistmodel.isNotEmpty
                      ? _addressProvider
                          .citylistmodel[_addressProvider.allcitylistindex].id!
                          .toString()
                      : '0',
                  'seller_name': sellernameController.text,
                  'seller_phone': sellerphoneController.text,
                  'seller_email': selleremailController.text,
                  'address': selleraddressController.text,
                  'user_id': MyApp.userid,
                };

                if (widget.adsapprovedData!.id != null) {
                  body['id'] = widget.adsapprovedData!.id.toString();
                  LoginApi registerresponse = LoginApi(body);
                  final response = await registerresponse.updateAds();
                  print(response);
                  if (response['status'] == 'true') {
                    print(imagefiles);
                    if (imagefiles != null) {
                      await imageupload(widget.adsapprovedData!.id.toString());
                    }
                    Navigator.pop(context);
                    DialogHelper.showFlutterToast(strMsg: response['message']);
                  } else if (response['error']['title'] != null) {
                    DialogHelper.showFlutterToast(
                        strMsg: response['error']['title'].toString());
                    setState(() {
                      error = response['error']['title'].toString();
                    });
                  }
                } else {
                  LoginApi registerresponse = LoginApi(body);
                  final response = await registerresponse.createAds();
                  print(response);
                  if (response['status'] == 'true') {
                    if (imagefiles!.isNotEmpty) {
                      await imageupload(response['ad_id'].toString());
                    }

                    Navigator.pop(context);
                    DialogHelper.showFlutterToast(strMsg: response['message']);
                  } else if (response['error'] != null) {
                    DialogHelper.showFlutterToast(
                        strMsg: response['error'].toString());
                    setState(() {
                      error = response['error'].toString();
                    });
                  }
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
        } else {
          DialogHelper.showFlutterToast(
              strMsg: "Veuillez sélectionner une sous-catégorie");
          setState(() {
            error = "Veuillez sélectionner une sous-catégorie";
          });
        }
      } else {
        DialogHelper.showFlutterToast(
            strMsg: "Veuillez sélectionner la catégorie");
        setState(() {
          error = "Veuillez sélectionner la catégorie";
        });
      }
    }
  }

  Future imageupload(String adid) async {
    if (imagefiles!.isNotEmpty) {
      var url = Uri.parse(UploadAdsImage);
      for (int i = 0; i < imagefiles!.length; i++) {
        final request = new http.MultipartRequest('POST', url);

        final file =
            await http.MultipartFile.fromPath('images', imagefiles![i].path);

        request.files.add(file);

        request.fields['user_id'] = MyApp.userid!;
        request.fields['ad_id'] = adid;
        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
          // Navigator.push<dynamic>(
          //   context,
          //   MaterialPageRoute<dynamic>(
          //     builder: (BuildContext context) => Home(),
          //   ),
          // );
          print(response.body);
          var out = jsonDecode(response.body);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreen(title: 'Déposer une annonce')),
      body:
          Consumer<AddressProvider>(builder: (context, addressProvider, child) {
        return Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 2.w,
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
                      height: 40,
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
                                      i <
                                          addressProvider
                                              .getalllistmodels.length;
                                      i++) {
                                    if (addressProvider
                                            .getalllistmodels[i].categoryId
                                            .toString() ==
                                        val.toString()) {
                                      setState(() {
                                        addressProvider.allcategoriesindex = i;
                                        addressProvider.allsubcategoriesindex =
                                            0;
                                        addressProvider.allsubcategoriesFetch =
                                            false;
                                        addressProvider.allbrandindex = 0;
                                        addressProvider.allbrandFetch = false;
                                      });
                                      addressProvider.allsubcategoryistdata(
                                          addressProvider
                                              .getalllistmodels[i].categoryId!);
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

                      // TextField(
                      //     readOnly: true,
                      //     decoration: InputDecoration(
                      //         filled: true,
                      //         fillColor: Color(0xFFFFFFFF),
                      //         suffixIcon: Icon(
                      //           Icons.arrow_drop_down,
                      //           color: Colors.black,
                      //           size: 35,
                      //         ),
                      //         border: OutlineInputBorder(),
                      //         labelText: 'choisissez une catégorie',
                      //         hintStyle: TextStyle(fontSize: 14.sp)
                      //         //hintText: ' choisissez une catégorie',
                      //         ),
                      //   ),
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
                    //  padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 40,
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
                                        addressProvider.allsubcategoriesindex =
                                            i;
                                        addressProvider.allbrandFetch = false;
                                        addressProvider.allbrandindex = 0;
                                      });
                                      addressProvider.allbrandlistdata(
                                          addressProvider
                                              .getsubcategorieslistmodels[i].id
                                              .toString());
                                      // statelistdata();
                                    }
                                  }
                                },
                              ),
                            )
                          // : TextField(
                          //     readOnly: true,
                          //     decoration: InputDecoration(
                          //         filled: true,
                          //         fillColor: Color(0xFFFFFFFF),
                          //         suffixIcon: Icon(
                          //           Icons.arrow_drop_down,
                          //           color: Colors.black,
                          //           size: 35,
                          //         ),
                          //         border: OutlineInputBorder(),
                          //         labelText: 'choisissez une Marque',
                          //         hintStyle: TextStyle(fontSize: 14.sp)
                          //         //hintText: ' choisissez une catégorie',
                          //         ),
                          //   ),

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
                                labelText: 'choisissez une Subcatégorie',
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
                    // padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 40,
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
                                      i <
                                          addressProvider
                                              .getbrandlistmodels.length;
                                      i++) {
                                    if (addressProvider.getbrandlistmodels[i].id
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

                  Text(
                    "Ignorez la sélection de la marque si vous le souhaitez Titre de l'annonce : ajoutez un titre",
                    style: TextStyle(
                      color: Color(0xff113f60),
                      fontSize: 14.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Ajouter un titre',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: addtitleController,
                    hinttext: 'Ajouter un titre',
                    validator: AppValidator.emptyValidator,
                  ),
                  // Text(
                  //   "Un peu de  caractères serait un bon titre d'annonce",
                  //   style: TextStyle(
                  //     color: new Color(0xff113f60),
                  //     fontSize: 14.sp,
                  //     fontFamily: 'Amazon',
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Latitude',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return PlacePicker(
                      //         apiKey: "",
                      //         initialPosition: CreateAds.kInitialPosition,
                      //         useCurrentLocation: true,
                      //         selectInitialPosition: true,
                      //         onPlacePicked: (result) async {
                      //           selectedPlace = result;
                      //           // siteController.text =
                      //           //     selectedPlace.formattedAddress;
                      //           sitelocation = selectedPlace.formattedAddress!;

                      //           var addresses = await Geocoder.local
                      //               .findAddressesFromQuery(
                      //                   selectedPlace.formattedAddress);
                      //           var first = addresses.first;
                      //           var locationdata = first.coordinates.toString();
                      //           var repl = locationdata.replaceAll("{", "");
                      //           var replall = repl.replaceAll("}", "");
                      //           // print(replall);
                      //           sitefinallocation = replall;
                      //           print("object use find ");
                      //           print(
                      //               "${"first.featureName"} : ${first.coordinates}");

                      //           Navigator.of(context).pop();

                      //           setState(() {});
                      //         },
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: Container(
                      // padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: latitudeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Longitude',
                            labelStyle: Style_File.subtitle
                                .copyWith(color: Colors.black, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Ajouter un lieu',
                    style: TextStyle(
                      color: new Color(0xff113f60),
                      fontSize: 14.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Longitude',
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
                      child: TextField(
                        controller: longitudeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Longitude',
                          labelStyle: Style_File.subtitle
                              .copyWith(color: Colors.black, fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Ajouter un lieu',
                    style: TextStyle(
                      color: new Color(0xff113f60),
                      fontSize: 14.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Ajouter une description',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  Column(
                    children: <Widget>[
                      Card(
                          color: colorlightGrey,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: adddescriptionController,
                                validator: AppValidator.emptyValidator,
                                maxLines: 8, //or null
                                decoration: InputDecoration.collapsed(
                                  hintText: "Enter your text here",
                                  hintStyle: Style_File.subtitle.copyWith(
                                      color: Colors.black, fontSize: 14.sp),
                                )),
                          ))
                    ],
                  ),
                  Text(
                    "Une description aidera l'utilisateur à connaître les détails de votre produit",
                    style: TextStyle(
                      color: new Color(0xff113f60),
                      fontSize: 14.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Ajouter un statut',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  //radio button
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Particulier';
                                id = 1;
                              });
                            },
                          ),
                          Text(
                            "Particulier",
                            style: new TextStyle(fontSize: 15.sp),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'Professionnel';
                                id = 2;
                              });
                            },
                          ),
                          Text(
                            "Professionnel",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Condition',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: conditionController,
                    hinttext: 'Condition',
                    validator: AppValidator.emptyValidator,
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Prix',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: priceController,
                    hinttext: 'Ex. 15000',
                    validator: AppValidator.emptyValidator,
                  ),

                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Text(
                            'Négociable',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Choisissez le bon prix',
                    style: TextStyle(
                      color: new Color(0xff113f60),
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Image',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Amazon',
                        ),
                      ),
                    ],
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
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 2.w,
                    children: [
                      GestureDetector(
                        onTap: () {
                          openImages();
                        },
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 12.h,
                          width: 12.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/download.png',
                                height: 4.h,
                                width: 4.h,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'importer une image',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (imagefiles != null)
                        for (int i = 0; i < imagefiles!.length; i++)
                          Container(
                            height: 12.h,
                            width: 12.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(imagefiles![i].path),
                                  ),
                                  fit: BoxFit.fill,
                                )),
                            // child: Image.file(
                            //   File(imagefiles![i].path),
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                      if (networkimage.isNotEmpty)
                        for (int i = 0; i < networkimage.length; i++)
                          Container(
                            height: 12.h,
                            width: 12.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imageurl + networkimage[i],
                                  ),
                                  fit: BoxFit.fill,
                                )),
                            // child: Image.file(
                            //   File(imagefiles![i].path),
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'URL de la vidéo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: videourlController,
                    hinttext: 'URL de la vidéo',
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Ces fonctionnalités ne sont disponibles que pour le thème moderne. si vous définissez la vidéo, la future image sera affichée dans la page des détails de l'annonce",
                    style: TextStyle(
                      color: new Color(0xff113f60),
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Information de Lieu',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  const Divider(
                    color: Colors.grey, //color of divider
                    height: 5, //height spacing of divider
                    thickness: 1, //thickness of divider line
                    indent: 1, //spacing at the start of divider
                    endIndent: 1, //spacing at the end of divider
                  ),
                  SizedBox(height: 2.h),
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
                    //padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 40,
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.all(2.w),
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
                      height: 40,
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
                                labelText: 'choisissez une Région',
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
                    //padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 40,
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
                                labelText: 'choisissez une Ville',
                                labelStyle: Style_File.subtitle.copyWith(
                                    color: Colors.black, fontSize: 14.sp),

                                //hintText: ' choisissez une catégorie',
                              ),
                            ),
                    ),
                  ),

                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Information de Lieu',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
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
                  Text(
                    'Nom du vendeur',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: sellernameController,
                    hinttext: 'Nom du vendeur',
                    validator: AppValidator.emptyValidator,
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Email du vendeur",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: selleremailController,
                    hinttext: 'Email du vendeur',
                    validator: AppValidator.emailValidator,
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Téléphone du vendeur",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: sellerphoneController,
                    hinttext: 'Téléphone du vendeur',
                    validator: AppValidator.emptyValidator,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Addresse',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 0.2.h,
                  ),
                  CreateTextFormScreen(
                    textEditingController: selleraddressController,
                    hinttext: 'Adresse',
                    validator: AppValidator.emptyValidator,
                  ),
                  Text(
                    "La ligne d'adresse aidera l'acheteur à connaître plus précisément votre emplacement",
                    style: TextStyle(
                      color: Color(0xff113f60),
                      fontSize: 14.sp,
                      fontFamily: 'Amazon',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Text(
                      error ?? '',
                      style: Style_File.subtitle
                          .copyWith(color: Colors.red, fontSize: 15.sp),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: SizedBox(
                        width: 70.w,
                        height: 5.h,
                        child: ElevatedButton(
                            child: Text(
                              "Enregistrer la nouvelle annonce",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontFamily: 'Amazon'),
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  colorPrimary,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        side: BorderSide(
                                          color: colorPrimary,
                                        )))),
                            onPressed: () {
                              setState(() {
                                error = '';
                              });
                              print("object");
                              if (widget.adsapprovedData!.id != null) {
                                formadd();
                              } else if (imagefiles != null) {
                                formadd();
                              } else {
                                error = "'Veuillez télécharger l'image'";
                                DialogHelper.showFlutterToast(
                                    strMsg: "'Veuillez télécharger l'image'");
                              }

                              //  Navigator.pushReplacementNamed(context, "/HomeScreen")
                            })),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
