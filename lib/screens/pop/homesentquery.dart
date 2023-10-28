import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomesentqueryScreens extends StatefulWidget {
  final Function callback;
  final String adsid;
  const HomesentqueryScreens({
    Key? key,
    required this.callback,
    required this.adsid,
  }) : super(key: key);

  @override
  State<HomesentqueryScreens> createState() => _HomesentqueryScreensState();
}

class _HomesentqueryScreensState extends State<HomesentqueryScreens> {
  TextEditingController _nameeditcontroller = new TextEditingController();
  TextEditingController _phoneeditcontroller = new TextEditingController();
  TextEditingController _emaileditcontroller = new TextEditingController();
  TextEditingController _messageeditcontroller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(MyApp.email_VALUE);
    _emaileditcontroller.text = MyApp.email_VALUE ?? '';
  }

  Future sentquery() async {
    var data = {
      'email': _emaileditcontroller.text,
      'name': _nameeditcontroller.text,
      'mobile': _phoneeditcontroller.text,
      'message': _messageeditcontroller.text,
      'ad_id': widget.adsid,
      'user_id': MyApp.userid ?? '0',
    };
    print(data.toString());
    LoginApi registerresponse = LoginApi(data);
    final response = await registerresponse.sentquery();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.callback("ok");
                    },
                    icon: Icon(Icons.close),
                  )
                ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Nom:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: _nameeditcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'E-mail:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: _emaileditcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Numéro de téléphone:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 30,
                          child: TextField(
                            controller: _phoneeditcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
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
                                  sentquery();
                                },
                                child: SizedBox(
                                    width: 80.0,
                                    height: 30.0,
                                    child: ElevatedButton(
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 1.0, right: 1.0),
                                        child: Text(
                                          "Envoyer un e-mail",
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
                                      onPressed: () => sentquery(),
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
