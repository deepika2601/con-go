import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateTextFormScreen extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool obscure;
  final bool suffixIcon;
  final Widget? suffixIconWidget;
  final void Function()? onPressed;
  final TextInputType? keyboardType;

  CreateTextFormScreen({
    Key? key,
    required this.textEditingController,
    required this.hinttext,
    this.icon,
    this.obscure = true,
    this.validator,
    this.readOnly = false,
    this.suffixIcon = false,
    this.suffixIconWidget,
    this.onPressed,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.zero,
      keyboardType: keyboardType,
      controller: textEditingController,
      readOnly: readOnly,
      obscureText: suffixIcon ? obscure : false,
      style: Style_File.detailstitle.copyWith(fontWeight: FontWeight.w400),
      decoration: InputDecoration(
          // isDense: true,
          contentPadding: EdgeInsets.only(left: 2.w, right: 2.w),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.w),
              borderSide: BorderSide(color: Colors.black26)),
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Amazon'),
          // prefixIcon: Icon(
          //   icon,
          //   size: 3.h,
          //   color: colorPrimary.withOpacity(0.6),
          // ),
          suffixIcon: suffixIcon
              ? suffixIconWidget ??
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: colorPrimary,
                      ))
              : null),
      validator: validator,
    );
  }
}
