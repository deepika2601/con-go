import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_helper/dialog_helper.dart';
import '../utils/string_file.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController{
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  final ImagePicker picker = ImagePicker();
  String? filePath;
  var deviceId = "".obs;
  File? imageFile;


  void showPopupMenu() async {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [



              const Text(
                'Choose option',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const Divider(color: Colors.black,),
              ListTile(
                leading:const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: (){
                  if (Get.isDialogOpen!) Get.back();
                  getImageFromCamera();
                },
              ),
              ListTile(
                leading:const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: (){
                  if (Get.isDialogOpen!) Get.back();
                  getImageFromGallery();
                },
              ),

            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }


  getImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      imageFile = File(image.path);
      filePath = image.path;
    }else{
      DialogHelper.showFlutterToast(strMsg: 'No File Selected');
    }
    update();
  }

  getImageFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if(photo != null){
      imageFile = File(photo.path);
      filePath = photo.path;
    }else{
      DialogHelper.showFlutterToast(strMsg: 'No File Selected');
    }
    update();
  }


  bool checkValidation({required String name, required String email, required String phone}){
    if(name.isEmpty){
      DialogHelper.showFlutterToast(strMsg: "Please enter ${StringFile.name}");
      return false;
    }
    if(email.isEmpty){
      DialogHelper.showFlutterToast(strMsg: "Please enter ${StringFile.email}");
      return false;
    }
    if(phone.isEmpty){
      DialogHelper.showFlutterToast(strMsg: "Please enter ${StringFile.phone}");
      return false;
    }
    return true;
  }
}

