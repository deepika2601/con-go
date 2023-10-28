import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/db_helper/dialog_helper.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/utils/app_validator.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/createformtext.dart';
import 'package:congobonmarche/utils/font_size.dart';
import 'package:congobonmarche/utils/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  TextEditingController _nameeditcontroller = new TextEditingController();
  TextEditingController _phoneeditcontroller = new TextEditingController();
  TextEditingController _emaileditcontroller = new TextEditingController();
  TextEditingController _messageeditcontroller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  formsave() async {
    if (_formKey.currentState!.validate()) {
      print(MyApp.userid);
      var data = {
        "name": _nameeditcontroller.text,
        "email": _emaileditcontroller.text,
        "topic": _phoneeditcontroller.text,
        "message": _messageeditcontroller.text,
        'user_id': MyApp.userid ?? '0',
      };
      LoginApi registerresponse = LoginApi(data);
      final response = await registerresponse.helpsupport();
      if (response['status'] == "true") {
        DialogHelper.showFlutterToast(strMsg: "Votre requête a été soumise !!");
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(MyApp.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          "Support d'aide",
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
        padding:  EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                 SizedBox(
                  height: 2.h,
                ),
                CreateTextFormScreen(
                  textEditingController: _nameeditcontroller,
                  hinttext: 'Nom et prénom',
                  validator: AppValidator.nameValidator,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CreateTextFormScreen(
                  textEditingController: _emaileditcontroller,
                  hinttext: 'E-mail',
                  validator: AppValidator.emailValidator,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CreateTextFormScreen(
                  textEditingController: _phoneeditcontroller,
                  hinttext: 'Sujette',
                  validator: AppValidator.emptyValidator,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  children: <Widget>[
                    Card(
                        color: colorlightGrey,
                        child: TextFormField(
                            controller: _messageeditcontroller,
                            validator: AppValidator.emptyValidator,
                            maxLines: 5, //or null
                            decoration: InputDecoration.collapsed(
                              hintText: " Entrez votre message ici...",
                             hintStyle: TextStyle( fontSize: 14.sp)
                            )))
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                    height: 5.h,
                    width: 90.w,
                    child: ElevatedButton(
                        child: const Text(
                          "Envoyez le message",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Amazon'),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
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
                        onPressed: () => {
                              formsave()
                              //  Navigator.pushReplacementNamed(context, "/HomeScreen")
                            })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
