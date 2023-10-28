import 'package:congobonmarche/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ImagesScreen extends StatelessWidget {
  final String url;
  const ImagesScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              imageurl + url,
            ),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
