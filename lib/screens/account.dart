import 'package:congobonmarche/apis/api.dart';
import 'package:congobonmarche/apis/loginapi.dart';
import 'package:congobonmarche/main.dart';
import 'package:congobonmarche/provider/profileuserprovider.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/screen/appbar.dart';
import 'package:congobonmarche/utils/screen/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../page_routes/routes.dart';
import '../utils/style_file.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isSignUpScreen = true;

  ProfileUserProvider _profileuserProvider = ProfileUserProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _profileuserProvider =
        Provider.of<ProfileUserProvider>(context, listen: false);
    _profileuserProvider.profileuserlist(MyApp.email_VALUE ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreen(title: 'Mon compte')),
      body: Consumer<ProfileUserProvider>(
          builder: ((context, profileUserProvider, child) {
        if (profileUserProvider.profileuserList.isEmpty) {
          return Center(child: LoaderScreen());
        } else {
          return SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                height: 20.h,
                //  decoration:
                //BoxDecoration(color: Color.fromARGB(255, 153, 200, 239)

                child: Row(
                  children: [
                    SizedBox(
                      width: 4.h,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 5.h,
                      backgroundImage: profileUserProvider
                              .profileuserList.isNotEmpty
                          ? profileUserProvider.profileuserList[0].photo != ''
                              ? NetworkImage(imageurlproile +
                                  profileUserProvider.profileuserList[0].photo
                                      .toString())
                              : AssetImage(
                                  'assets/images/profile.png',
                                ) as ImageProvider
                          : AssetImage(
                              'assets/images/profile.png',
                            ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                                profileUserProvider.profileuserList.isNotEmpty
                                    ? profileUserProvider
                                            .profileuserList[0].name ??
                                        ''
                                    : '',
                                style: Style_File.title
                                    .copyWith(fontSize: 18.sp))),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Center(
                            child: Text(
                                profileUserProvider.profileuserList.isNotEmpty
                                    ? profileUserProvider
                                            .profileuserList[0].email ??
                                        ''
                                    : '',
                                style: Style_File.subtitle.copyWith(
                                    fontSize: 16.sp, color: colorBlack))),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  profileUserProvider.profileuserList.isNotEmpty
                      ? accountTextUI(
                          context,
                          Icons.edit_note,
                          "Editer le profil",
                          Icons.arrow_forward_ios,
                          Routes.editProfileScreen,
                          arguments: {
                              'profileuserdata':
                                  profileUserProvider.profileuserList,
                            })
                      : Container(),
                  accountTextUI(context, Icons.help_outline, "Centre d'aide",
                      Icons.arrow_forward_ios, Routes.helpSupport),
                  accountTextUI(
                    context,
                    Icons.location_on_outlined,
                    "Carnet d'adresse",
                    Icons.arrow_forward_ios,
                    Routes.location,
                  ),
                  accountTextUI(
                    context,
                    Icons.credit_card,
                    "Paiement",
                    Icons.arrow_forward_ios,
                    Routes.paymentDetails,
                  ),
                  // accountTextUI(
                  //   context,
                  //   Icons.share,
                  //   "Partager l'application",
                  //   Icons.arrow_forward_ios,
                  //   Routes.location,
                  // ),
                  // accountTextUI(
                  //   context,
                  //   Icons.star_rate_rounded,
                  //   "Évaluez nous",
                  //   Icons.arrow_forward_ios,
                  //   Routes.location,
                  // ),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            size: 25.0,
                            color: colorGrey,
                          ),
                          label: Text('Supprimer le compte',
                              style: Style_File.title)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              // onPressed: () => navigation,
                              onPressed: () {
                                // Navigator.push(context,
                                //         MaterialPageRoute(builder: (context) => navigation))
                                //     .then((value) {
                                //   _profileuserProvider
                                //       .profileuserlist(MyApp.email_VALUE ?? '');
                                // });
                                print(MyApp.userid);
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Se déconnecter"),
                                    content: Text(
                                        "Êtes-vous sûr de vouloir supprimer le compte !"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("annuler"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          var body = {
                                            "email": MyApp.email_VALUE,
                                          };
                                          LoginApi loginApi = LoginApi(body);
                                          final responses =
                                              await loginApi.deleteacount();
                                          if (responses['status'] == 'true') {
                                            await MyApp.logout();
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    Routes.homeScreen,
                                                    (Route<dynamic> route) =>
                                                        false);
                                          }
                                        },
                                        child: Text("D'accord"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          );
        }
      })),
    );
  }

  Widget accountCardUI(String imagename, String title) {
    return Column(
      children: [
        Image(
          image: AssetImage(
            imagename,
          ),
          width: 5.h,
          height: 5.h,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: Style_File.subtitle.copyWith(color: colorWhite),
        )
      ],
    );
  }

  Widget accountTextUI(
    BuildContext context,
    IconData icon1,
    String title,
    IconData icon2,
    String navigation, {
    Object? arguments,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              icon1,
              size: 25.0,
              color: colorGrey,
            ),
            label: Text(title, style: Style_File.title)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                // onPressed: () => navigation,
                onPressed: () {
                  // Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => navigation))
                  //     .then((value) {
                  //   _profileuserProvider
                  //       .profileuserlist(MyApp.email_VALUE ?? '');
                  // });
                  print(MyApp.userid);
                  Navigator.pushNamed(context, navigation, arguments: arguments)
                      .then((value) {
                    print(MyApp.userid);
                    _profileuserProvider
                        .profileuserlist(MyApp.email_VALUE ?? '');
                  });
                },
                icon: Icon(
                  icon2,
                  size: 25.0,
                  color: Colors.grey,
                )),
          ],
        ),
      ],
    );
  }
}
