// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:taskes/core/color.dart';
import 'package:taskes/core/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = mainColor,
  });
  final String text;
  final VoidCallback onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.r),
          ),
          maximumSize: const Size(370, 37),
          minimumSize: const Size(370, 37)),
      onPressed: onPressed,
      child: Text(text,
          style: Styles.textstyle20
              .copyWith(color: const Color.fromRGBO(255, 255, 255, 1))),
    );
  }
}
