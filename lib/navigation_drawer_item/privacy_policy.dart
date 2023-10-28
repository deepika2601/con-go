import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../page_routes/routes.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';
import '../utils/text_widget.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  var categoryName = "Politique de confidentialité";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: TextView(
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
          font_size: isMobile(context)
              ? MyFontSize().normalTextSizeMobile
              : MyFontSize().normalTextSizeTablet,
          fontColor: colorWhite,
          text: categoryName,
          textStyle: Theme.of(context).textTheme.bodyText1!,
          softWrap: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "Politique de confidentialité: En accédant au Congobonmarche.com, vous acceptez les Conditions Générales d’Utilisation ci-dessous. Congobonmarche.com se réserve le droit de modifier à n’importe quel moment et sans préavis ces présentes Conditions Générales d’Utilisation. OBJET Congobonmarche.com est un site Internet de petites annonces principalement destinées aux particuliers. Il facilite la mise en relation entre acheteurs et vendeurs",
              style: Style_File.subtitle.copyWith(color: colorBlack),
            ),
          ),
        ),
      ),
    );
  }
}
