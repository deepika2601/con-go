import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/provider/adsapprovedprovider.dart';
import 'package:congobonmarche/screens/adsapprovedui.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class AdsPendingScreen extends StatefulWidget {
  const AdsPendingScreen({Key? key}) : super(key: key);
  @override
  State<AdsPendingScreen> createState() => _AdsPendingScreenState();
}

class Toplist {
  Toplist(
    this.image,
  );
  final String image;
}

class _AdsPendingScreenState extends State<AdsPendingScreen> {
  AdsapprovedProvider _adsapprovedProvider = AdsapprovedProvider();
  TextEditingController sercheditcontroler = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _adsapprovedProvider =
        Provider.of<AdsapprovedProvider>(context, listen: false);
    _adsapprovedProvider.adspendinglist();
  }

  String searchString = '';
  bool searchshow = false;

  Future deleteaddress(String id) async {
    var body = {'id': id};
    LoginApi registerresponse = LoginApi(body);
    final response = await registerresponse.adsdelete();
    print(response);
    if (response['status'] == 'true') {
      _adsapprovedProvider.adspendinglist();
      DialogHelper.showFlutterToast(strMsg: response['message']);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsapprovedProvider>(builder: ((context, value, child) {
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
              : Text("Mes annonces(En attente)"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            // onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_outlined),
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
            //       _adsapprovedProvider.adspendinglist();
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
        body: value.adsapprovedModel.data != null
            ? AdsapprovedUI(
                alladsapproveddata: value.adsapprovedList,
                callback: (value) {
                  if (value == "edit") {
                    _adsapprovedProvider.adspendinglist();
                  } else if (value != null) {
                    deleteaddress(value);
                  }
                },
                type: "pending",
                searchString: searchString,
              )
            : SizedBox(
                width: Get.width,
                height: Get.height,
                child: Center(
                    child: (value.adsapprovedList.isNotEmpty)
                        ? CircularProgressIndicator(
                            color: colorPrimary,
                          )
                        : Text(
                            "Aucune donnée disponible",
                            style: Style_File.title,
                          )),
              ),
      );
    }));
  }
}
