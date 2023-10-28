import 'dart:convert';
import 'dart:io';

import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/model/profileuserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/edit_profile_controller.dart';
import '../db_helper/sqlite_database.dart';
import '../helper/storage_helper_keys.dart';
import '../utils/colors.dart';
import '../utils/contants.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';
import '../utils/string_file.dart';
import '../utils/style_file.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final List<ProfileUserData>? profileuserdata;
  const EditProfileScreen({Key? key, this.profileuserdata}) : super(key: key);
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameeditcontroller = new TextEditingController();
  TextEditingController _phoneeditcontroller = new TextEditingController();
  TextEditingController _emaileditcontroller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.profileuserdata!.isNotEmpty) {
      _emaileditcontroller.text = widget.profileuserdata![0].email ?? '';
      _nameeditcontroller.text = widget.profileuserdata![0].name ?? '';
      _phoneeditcontroller.text = widget.profileuserdata![0].mobile ?? '';
    }
    super.initState();
  }

  Future submitupdate() async {
    if (imagefiles != null) {
      var url = Uri.parse(ProfileUpdate);

      final request = new http.MultipartRequest('POST', url);

      final file = await http.MultipartFile.fromPath('photo', imagefiles!.path);

      request.files.add(file);

      request.fields['email'] = _emaileditcontroller.text;
      request.fields['name'] = _nameeditcontroller.text;
      request.fields['mobile'] = _phoneeditcontroller.text;
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
        if (out['status'] == "true") {
          DialogHelper.showFlutterToast(strMsg: out['message']);
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
      }
    } else {
      var data = {
        'email': _emaileditcontroller.text,
        'name': _nameeditcontroller.text,
        'mobile': _phoneeditcontroller.text,
      };
      print(data.toString());
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.updateprofile();
      print(response);
      if (response['status'] == "true") {
        DialogHelper.showFlutterToast(strMsg: response['message']);
        Navigator.pop(context);
      }
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  XFile? imagefiles;
  openImages() async {
    try {
      final XFile? image =
          await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture

      if (image != null) {
        imagefiles = image;
        setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          centerTitle: true,
          title: Text(
            "Editer le profil",
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
        body: Padding(
          padding: EdgeInsets.all(2.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 6.h,
                      backgroundImage: imagefiles != null
                          ? FileImage(File(imagefiles!.path))
                          : widget.profileuserdata![0].photo != null
                              ? NetworkImage(imageurlproile +
                                  widget.profileuserdata![0].photo.toString())
                              : AssetImage(
                                  "assets/images/profile.png",
                                ) as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            openImages();
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: colorSecondry,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    StringFile.name,
                    textAlign: TextAlign.center,
                    style: Style_File.title,
                  ),
                  Container(
                      width: Get.width,
                      height: 45,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: colorGrey, width: 1),
                      ),
                      child: TextField(
                        controller: _nameeditcontroller,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    StringFile.phone,
                    style: Style_File.title,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: Get.width,
                      height: 45,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: colorGrey, width: 1),
                      ),
                      child: TextField(
                        controller: _phoneeditcontroller,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    StringFile.email,
                    style: Style_File.title,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: Get.width,
                      height: 45,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: colorGrey, width: 1),
                      ),
                      child: TextField(
                        controller: _emaileditcontroller,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(border: InputBorder.none),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        submitupdate();
                      },
                      child: Text(
                        StringFile.submit.toUpperCase(),
                        style: TextStyle(
                            color: colorWhite,
                            fontFamily: Contants().FONT_KEY_NAME_AMAZON,
                            fontSize: isMobile(context)
                                ? MyFontSize().mediumTextSizeMobile
                                : MyFontSize().mediumTextSizeTablet),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(Get.width / .1, 45),
                          primary: colorPrimary,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
