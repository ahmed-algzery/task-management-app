// Function to display a SnackBar message

import 'package:flutter/material.dart';
import 'package:taskes/core/styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showSnackBar(BuildContext context, String text, bool status) {
  if (status == true) {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: text,
        backgroundColor: Colors.green,
        textStyle: Styles.textstyle18,
      ),
    );
  } else {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: text,
      ),
    );
  }
}
