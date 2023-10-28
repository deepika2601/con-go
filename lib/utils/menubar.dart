import 'package:congobonmarche/auth/loginall.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/screens/home.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuBarScreens extends StatelessWidget {
  const MenuBarScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("object userid ${MyApp.userid}");
    return Drawer(
      backgroundColor: colorPrimary,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            Container(
              height: 15.h,
              child: DrawerHeader(
                child: Image.asset(
                  'assets/images/logo.png',
                  color: colorWhite,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('Accueil',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.homeScreen, (route) => false);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              // leading: IconButton(
              //   icon: Image.asset('assets/images/c4.png',
              //       height: 15, fit: BoxFit.fill),
              //   // Icons.add_circle_sharp,
              //   color: Colors.white,
              //   onPressed: () {
              //     Navigator.pushReplacementNamed(context, "/CategoryScreen");
              //   },
              // ),

              leading: const Icon(
                Icons.grid_view_rounded,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('Catégorie',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              // one page to another best way for redirection.
              onTap: () {
                Navigator.pushNamed(context, Routes.categoryScreen);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.ads_click,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('Annonces (Boutiques)',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushNamed(context, Routes.adsBoutiques);
              },
            ),
            if (MyApp.userid != null)
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            if (MyApp.userid != null)
              ExpansionTile(
                leading: const Icon(
                  Icons.animation,
                  size: 18,
                  color: Colors.white,
                ),
                title: const Text('Mes annonces',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Amazon',
                    )),
                children: <Widget>[
                  const Divider(
                    thickness: 1.0,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0.w),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const Text(" Déposer une annonce",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Amazon',
                                              )),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.createAds);
                                    },
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0.w),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const Text(
                                              " En attente d'approbation",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Amazon',
                                              )),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.adsPendingScreen);
                                    },
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0.w),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.list,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const Text(" Annonce approuvée",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Amazon',
                                              )),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.adsApproved);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outlined,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('Informations',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushNamed(context, Routes.information);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            if (MyApp.userid != null)
              ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  size: 18,
                  color: Colors.white,
                ),
                title: const Text('Mon compte',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Amazon',
                    )),
                onTap: () {
                  Navigator.pushNamed(context, Routes.accountScreen);
                },
              ),
            if (MyApp.userid != null)
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ListTile(
              leading: const Icon(
                Icons.money,
                size: 18,
                color: Colors.white,
              ),
              title: const Text('Notre Forfait',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () {
                Navigator.pushNamed(context, Routes.ourpackage);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(
                Icons.login,
                size: 18,
                color: Colors.white,
              ),
              title: Text(
                  MyApp.userid == null ? 'Connectez-vous' : 'Se déconnecter',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  )),
              onTap: () async {
                if (MyApp.userid == null) {
                  Navigator.pushNamed(context, Routes.loginAll);
                } else {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Se déconnecter"),
                      content:
                          Text("Êtes-vous sûr de vouloir vous déconnecter !"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text("annuler"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await MyApp.logout();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.homeScreen,
                                (Route<dynamic> route) => false);
                          },
                          child: Text("D'accord"),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
