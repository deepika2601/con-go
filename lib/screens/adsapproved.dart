import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../apis/api_client.dart';
import '../provider/adsapprovedprovider.dart';
import 'adsapprovedui.dart';
import 'home.dart';

class AdsApproved extends StatefulWidget {
  const AdsApproved({Key? key}) : super(key: key);
  @override
  State<AdsApproved> createState() => _AdsApprovedState();
}

class _AdsApprovedState extends State<AdsApproved> {
  AdsapprovedProvider _adsapprovedProvider = AdsapprovedProvider();
  String searchString = '';
  bool searchshow = false;
  TextEditingController sercheditcontroler = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _adsapprovedProvider =
        Provider.of<AdsapprovedProvider>(context, listen: false);
    _adsapprovedProvider.adsapprovedlist();
  }

  Future deleteaddress(String id) async {
    var body = {'id': id};
    LoginApi registerresponse = LoginApi(body);
    final response = await registerresponse.adsdelete();
    print(response);
    if (response['status'] == 'true') {
      _adsapprovedProvider.adsapprovedlist();
      DialogHelper.showFlutterToast(strMsg: response['message']);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _adsapprovedProvider =
        Provider.of<AdsapprovedProvider>(context, listen: true);

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
            : Text('Mes annonces (Approuvée)'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          //    onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_outlined),
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
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, Routes.createAds).then((value) {
          //       _adsapprovedProvider.adsapprovedlist();
          //     });
          //   },
          //   icon: const Icon(Icons.add_circle_outlined),
          // ),
        ],
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color(0xffbf1f30),
      ),
      //body section

      body: Consumer<AdsapprovedProvider>(
        builder: ((context, value, child) {
          return _adsapprovedProvider.adsapprovedModel.data != null
              ? AdsapprovedUI(
                  alladsapproveddata: _adsapprovedProvider.adsapprovedList,
                  callback: (value) {
                    if (value == "edit") {
                      _adsapprovedProvider.adsapprovedlist();
                    } else if (value != null) {
                      deleteaddress(value);
                    }
                  },
                  searchString: searchString,
                  type: "approved",
                )
              : SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Center(
                    child: _adsapprovedProvider.adsapprovedList.isNotEmpty
                        ? CircularProgressIndicator(
                            color: colorPrimary,
                          )
                        : Text(
                            "Aucune donnée disponible",
                            style: Style_File.title,
                          ),
                  ),
                );
        }),
      ),
    );
  }
}
