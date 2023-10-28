// ignore_for_file: must_be_immutable

import 'package:congobonmarche/page_routes/routes.dart';
import 'package:congobonmarche/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBarScreen extends StatelessWidget {
  List<Widget>? actions;
  String? title;
  final void Function()? onPressed;
  AppBarScreen({Key? key, this.title, this.actions, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        // onPressed: () {
        //   Navigator.pop(context);
        // },
        onPressed: () {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.homeScreen, (route) => false);
          Navigator.pop(context);
        },
      ),
      automaticallyImplyLeading: false,
      actions: actions,
      centerTitle: true,
      elevation: 10,
      backgroundColor: colorPrimary,
    );
  }
}
