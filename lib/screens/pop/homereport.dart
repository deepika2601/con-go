import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/contants.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomesentreportScreens extends StatefulWidget {
  final Function callback;
  final String adsid;
  const HomesentreportScreens({
    Key? key,
    required this.callback,
    required this.adsid,
  }) : super(key: key);

  @override
  State<HomesentreportScreens> createState() => _HomesentreportScreensState();
}

class _HomesentreportScreensState extends State<HomesentreportScreens> {
  TextEditingController _emaileditcontroller = new TextEditingController();
  TextEditingController _messageeditcontroller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Contenu sexuel"), value: "Contenu sexuel"),
      DropdownMenuItem(
          child: Text("abus sur mineur"), value: "abus sur mineur"),
      DropdownMenuItem(
          child: Text("Contenu violent ou répulsif"),
          value: "Contenu violent ou répulsif"),
      DropdownMenuItem(
          child: Text("Spam ou trompeur"), value: "Spam ou trompeur"),
    ];
    return menuItems;
  }

  String selectedValue = "Contenu sexuel";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emaileditcontroller.text = MyApp.email_VALUE ?? '';
  }

  Future sentreport() async {
    var data = {
      'email': MyApp.email_VALUE,

      'message': _messageeditcontroller.text,
      'ad_id': widget.adsid,
      "reason": "other"
      // 'user_id': MyApp.userid ?? '0',
    };
    print(data.toString());
    LoginApi registerresponse = LoginApi(data);
    final response = await registerresponse.sentreport();
    if (response['status'] == "true") {
      LoginApi registerresponse = LoginApi(data);
      final responses = await registerresponse.sendnotification();
      print(responses);
      widget.callback("ok");
      DialogHelper.showFlutterToast(strMsg: response['message']);
    } else {
      widget.callback("ok");
      DialogHelper.showFlutterToast(strMsg: response['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: 60.h,
            width: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      " Signaler des annonces",
                      style: Style_File.title.copyWith(color: colorPrimary),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        widget.callback("ok");
                      },
                      icon: Icon(Icons.close),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Type de rapport:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Amazon',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButton(
                            isExpanded: true,
                            value: selectedValue,
                            style: Style_File.title,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: dropdownItems),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: const [
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //       'E-mail:',
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: 12,
                      //         fontFamily: 'Amazon',
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   child: SizedBox(
                      //     height: 30,
                      //     child: TextField(
                      //       controller: _emaileditcontroller,
                      //       decoration: InputDecoration(
                      //         border: OutlineInputBorder(),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Message:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Amazon',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                    maxLines: 2, //or null
                                    controller: _messageeditcontroller,
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Entrez votre requête",
                                      hintStyle: TextStyle(fontSize: 12),
                                    )),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 60.0,
                                height: 35.0,
                                child: TextButton(
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 5.0),
                                    child: Text('proche',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Amazon')),
                                  ),
                                  style: TextButton.styleFrom(
                                    primary: colorPrimary,
                                    onSurface: Colors.white,
                                    side: const BorderSide(
                                        color: Colors.black, width: 1),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                  ),
                                  onPressed: () {
                                    widget.callback("ok");
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  sentreport();
                                },
                                child: SizedBox(
                                    width: 80.0,
                                    height: 30.0,
                                    child: ElevatedButton(
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.0, right: 1.0),
                                        child: Text(
                                          "D'accord",
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontFamily: 'Amazon'),
                                        ),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  side: BorderSide(
                                                    color: colorPrimary,
                                                  )))),
                                      onPressed: () => sentreport(),
                                      // onPressed: () => {}
                                    )),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
