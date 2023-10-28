import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../page_routes/routes.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';
import '../utils/text_widget.dart';

class Information extends StatelessWidget {
  var categoryName = "Informations";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: colorBlack,
            size: 25,
          ),
          onTap: () {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, Routes.homeScreen, (route) => false);
            Navigator.pop(context);
          },
        ),
        title: TextView(
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
          font_size: isMobile(context)
              ? MyFontSize().normalTextSizeMobile
              : MyFontSize().normalTextSizeTablet,
          fontColor: Colors.black,
          text: categoryName,
          textStyle: Theme.of(context).textTheme.bodyText1!,
          softWrap: true,
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 25.h,
                  width: 25.h,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        ImageIcon(
                          AssetImage(
                            "assets/images/terms.png",
                          ),
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Termes et conditions",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Amazon',
                              fontWeight: FontWeight.bold,
                              color: colorBlack),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.termscondition);
                        },
                        icon: const Icon(Icons.forward))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage("assets/images/policy.png"),
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Politique de confidentialité",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Amazon',
                              fontWeight: FontWeight.bold,
                              color: colorBlack),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.privacypolicy);
                        },
                        icon: Icon(Icons.forward))
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 5.h,
                          width: 5.h,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "À propos de CongoBonMarche",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Amazon',
                              fontWeight: FontWeight.bold,
                              color: colorBlack),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.about);
                        },
                        icon: const Icon(Icons.forward))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
