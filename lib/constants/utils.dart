import 'package:flutter/material.dart';
import 'package:mother_international_comp_website/constants/app_colors.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: AppColors.mainBlue,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
