import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';
import 'package:mother_international_comp_website/widgets/nav_item.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 70,
      // color: Colors.green,
      padding: EdgeInsets.only(
          left: size.width * .1, right: size.width * .1, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'HOME',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.mainBlue, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: size.width * .2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.aboutRoute,
                      arguments: {'page': 'about'}),
                  child: const NavButton(text: 'About', page: 'About'),
                ),
                const FlutterLogo(
                  size: 20,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.registerRoute,
                      arguments: {'page': 'register'}),
                  child:
                      const NavButton(text: 'Enter Online', page: 'Register'),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.contactRoute,
                arguments: {'page': 'contact'}),
            child: const NavButton(text: 'Contact Us', page: 'Contact Us'),
          ),
        ],
      ),
    );
  }
}
