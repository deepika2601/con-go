import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeLoginPopScreens extends StatelessWidget {
  final Function callback;
  HomeLoginPopScreens({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 20.h,
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
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      callback("ok");
                    },
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Veuillez vous connecter avant d'ajouter des annonces",
                      style: Style_File.title,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.loginAll);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        alignment: Alignment.center,
                        height: 35,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(20.h),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 20),
                              blurRadius: 50,
                              color: Colors.white,
                            )
                          ],
                        ),
                        child: const Text(
                          "CONNEXION",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Amazon',
                          ),
                        ),
                      ),
                    ),
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
