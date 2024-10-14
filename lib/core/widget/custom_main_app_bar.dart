import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskes/core/assets.dart';
import 'package:taskes/core/styles.dart';

import '../color.dart';

class CustomMainAppBar extends StatelessWidget {
  const CustomMainAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      centerTitle: true,
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Styles.textstyle30,
            ),
            SizedBox(
              width: 35.w,
            ),
            Image.asset(
              Assets.logo,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
