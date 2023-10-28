import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: Text(
          "Paiement",
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 300.0),
          child: Center(
            child: Text(
              "Aucune donnée disponible",
              style: TextStyle(
                  color: Colors.black, fontSize: 15, fontFamily: 'Amazon'),
            ),
          ),
        ),
      ),
    );
  }
}
