import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';

import '../constants/app_colors.dart';
import 'on_hover.dart';

class NavButton extends StatefulWidget {
  const NavButton({
    Key? key,
    required this.text,
    required this.page,
  }) : super(key: key);

  final String text;
  final String page;
  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == '/' && widget.text == 'Home') {
      return Text(
        widget.text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 20, color: AppColors.mainBlue),
      );
    }
    if (Get.currentRoute == AppRoutes.contactRoute &&
        widget.text == 'Contact') {
      return Text(
        widget.text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 20, color: AppColors.mainBlue),
      );
    }
    if (Get.currentRoute == AppRoutes.aboutRoute && widget.text == 'About') {
      return Text(
        widget.text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 20, color: AppColors.mainBlue),
      );
    }
    if (Get.currentRoute == AppRoutes.registerRoute &&
        widget.text == 'Register') {
      return Text(
        widget.text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 20, color: AppColors.mainBlue),
      );
    }
    return OnHover(
      isNav: true,
      builder: (isHovered) {
        return Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: isHovered ? 20 : null,
              color: isHovered ? AppColors.mainBlue : Colors.white),
        );
      },
    );
  }
}
