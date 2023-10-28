
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget{
  String text;
  double font_size;
  bool softWrap;
  FontWeight fontWeight;
  Color fontColor;
  TextAlign textAlign;
  TextStyle textStyle;
  FontStyle fontStyle;



  TextView(
      {
        required this.text,
        required this.font_size,
        required this.fontWeight,
        required this.fontColor,
        required this.textAlign,
        required this.textStyle, this.softWrap = false, this.fontStyle = FontStyle.normal});

  Widget build(BuildContext context){
    return Text(
      text, textAlign: textAlign,
      style: GoogleFonts.roboto(
          textStyle: textStyle,
          fontSize: font_size,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          color: fontColor
      ),
    );
  }
}