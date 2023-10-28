import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/model/addresslistmodel.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/provider/addressprovider.dart';
import 'package:congobonmarche/utils/string_file.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  AddressProvider _addressProvider = AddressProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressProvider = Provider.of<AddressProvider>(context, listen: false);
    _addressProvider.addresslistdata();
  }

  Future deleteaddress(String id) async {
    var body = {'id': id};
    LoginApi registerresponse = LoginApi(body);
    final response = await registerresponse.addressdelete();
    print(response);
    if (response['status'] == 'true') {
      _addressProvider.addresslistdata();
      DialogHelper.showFlutterToast(strMsg: response['message']);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          "Carnet d'adresse",
          style: TextStyle(
            color: colorWhite,
            fontFamily: 'Amazon',
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
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.shipping).then((value) {
                    _addressProvider.addresslistdata();
                  });
                },
                child: Container(
                  height: 80,
                  width: 350,
                  color: colorDarklightGrey,
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        "+  Ajouter une nouvelle adresse",
                        style: TextStyle(
                          fontSize: 14,
                          color: colorBlack,
                          fontFamily: 'Amazon',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (addressProvider.addresslistmodels.isNotEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: addressProvider.addresslistmodels.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 1.0.h),
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: colorWhite,
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3.0,
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addressProvider
                                        .addresslistmodels[index].address ??
                                    '',
                                style: Style_File.detailstitle,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                addressProvider
                                        .addresslistmodels[index].zipcode ??
                                    '',
                                style: Style_File.subtitle,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Boîte de dialogue Matériau'),
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
                                                      deleteaddress(
                                                          addressProvider
                                                              .addresslistmodels[
                                                                  index]
                                                              .id
                                                              .toString());
                                                    },
                                                    child: Text("D'accord"),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: colorPrimary,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.shipping,
                                            arguments: {
                                              StringFile.addressdetails:
                                                  addressProvider
                                                      .addresslistmodels[index]
                                            }).then((value) {
                                          _addressProvider.addresslistdata();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            const SizedBox(
              height: 10,
            ),
          ])),
        );
      }),
    );
  }
}
