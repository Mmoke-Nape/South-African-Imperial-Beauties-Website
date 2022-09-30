import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';
import 'package:mother_international_comp_website/screens/home/widgets/winner_display_item.dart';

import '../../../responsive/responsive.dart';
import '../../../widgets/custom_button.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: Responsive.isMobile(context) ? size.height * 1.5 : size.height,
      width: size.width,
      // color: Colors.green,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          //Left Side
          Positioned(
            bottom: Responsive.isMobile(context) ? null : size.height * .1,
            top: Responsive.isMobile(context) ? size.height * .67 : null,
            left: Responsive.isMobile(context)
                ? size.width * .1
                : size.width * .07,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Kendall Savage.png',
              title: 'World Imperial Junior Miss',
            ),
          ),
          Positioned(
            top: Responsive.isMobile(context) ? 70 : 0,
            left: Responsive.isMobile(context)
                ? size.width * .09
                : size.width * .12,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Jalynn Brown.png',
              title: 'World Imperial Junior Teen',
            ),
          ),
          Positioned(
            bottom: Responsive.isMobile(context) ? null : size.height * .23,
            top: Responsive.isMobile(context) ? size.height * .36 : null,
            left: Responsive.isMobile(context)
                ? size.width * .12
                : size.width * .25,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Teagan Fields.png',
              title: 'World Imperial Preteen',
            ),
          ),

          //Right Side
          Positioned(
            bottom: Responsive.isMobile(context) ? null : size.height * .1,
            top: Responsive.isMobile(context) ? size.height * .75 : null,
            right: Responsive.isMobile(context)
                ? size.width * .1
                : size.width * .07,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Lilly Parker.png',
              title: 'World Imperial Teen',
              isOnRightSide: true,
            ),
          ),
          Positioned(
            top: Responsive.isMobile(context)
                ? size.height * .12
                : size.height * .1,
            right: size.width * .12,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Yolanda Grayson.png',
              title: 'World Imperial Ms.',
              isOnRightSide: true,
            ),
          ),
          Positioned(
            bottom: Responsive.isMobile(context) ? null : size.height * .23,
            top: Responsive.isMobile(context) ? size.height * .43 : null,
            right: Responsive.isMobile(context)
                ? size.width * .12
                : size.width * .25,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Lauren Madison.png',
              title: 'World Imperial Miss',
              isOnRightSide: true,
            ),
          ),

          //Center
          Positioned(
            bottom: Responsive.isMobile(context) ? null : size.height * .05,
            top: Responsive.isMobile(context) ? size.height * 1 : null,
            right: Responsive.isMobile(context)
                ? size.width * .4
                : size.width * .45,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Diane Boyd.png',
              title: 'World Imperial Classic Ms.',
              isCenter: true,
            ),
          ),
          if (Responsive.isMobile(context))
            Positioned(
              top: -20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Become Royalty',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 60),
                ),
              ),
            ),
          if (!Responsive.isMobile(context))
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: Responsive.isMobile(context) ? 10 : 50),
                child: Column(
                  children: [
                    Text(
                      'Become Royalty',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 90),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'REGISTER ONLINE',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.black87,
                          fontSize: Responsive.isMobile(context) ? 22 : 33,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 70),
                    CustomButton(
                      press: () => Get.toNamed(AppRoutes.registerRoute),
                      title: 'ENTER NOW',
                    ),
                  ],
                ),
              ),
            ),
          if (Responsive.isMobile(context))
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'REGISTER ONLINE',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.black87,
                          fontSize: Responsive.isMobile(context) ? 22 : 33,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      press: () => Get.toNamed(AppRoutes.registerRoute),
                      title: 'ENTER NOW',
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
