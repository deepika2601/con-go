import 'package:congobonmarche/utils/colors.dart';
import 'package:congobonmarche/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFormScreen extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool obscure;
  final bool suffixIcon;
  final Widget? suffixIconWidget;
  final void Function()? onPressed;
  final TextInputType? keyboardType;

  TextFormScreen({
    Key? key,
    required this.textEditingController,
    required this.hinttext,
    required this.icon,
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
      keyboardType: keyboardType,
      controller: textEditingController,
      readOnly: readOnly,
      obscureText: suffixIcon ? obscure : false,
      style: Style_File.detailstitle.copyWith(fontWeight: FontWeight.w400),

      // decoration: InputDecoration(
      //     hintText: hinttext,
      //     hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Amazon'),
      //     enabledBorder: const UnderlineInputBorder(
      //       borderSide: BorderSide(
      //         color: Colors.grey,
      //       ),
      //     ),
      //     prefixIcon: Icon(
      //       icon,
      //       size: 3.h,
      //       color: colorPrimary.withOpacity(0.6),
      //     ),
      //     suffixIcon: suffixIcon
      //         ? suffixIconWidget ??
      //             IconButton(
      //                 onPressed: onPressed,
      //                 icon: Icon(
      //                   obscure ? Icons.visibility_off : Icons.visibility,
      //                   color: colorPrimary,
      //                 ))
      //         : null),

      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hinttext,
          hintStyle: TextStyle(
            fontSize: 14.sp,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.w),
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.w),
              )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.w),
              )),
          prefixIcon: Icon(
            icon,
            color: colorPrimary.withOpacity(0.6),
            size: 2.5.h,
            // color: AppColors.appPrimarycolor,
          ),
          suffixIcon: suffixIcon
              ? suffixIconWidget ??
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        //   obscure1 ? Icons.visibility_off : Icons.visibility,
                        // color: colorBlack,
                      ))
              : null),

      validator: validator,
    );
  }
}
