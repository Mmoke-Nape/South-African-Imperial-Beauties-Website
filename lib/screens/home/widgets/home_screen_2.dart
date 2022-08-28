import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';
import 'package:mother_international_comp_website/screens/home/widgets/winner_display_item.dart';

import '../../../widgets/custom_button.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      // color: Colors.green,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          //Left Side
          Positioned(
            bottom: size.height * .1,
            left: size.width * .07,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Kendall Savage.png',
              title: 'World Imperial Junior Miss',
            ),
          ),
          Positioned(
            top: 0,
            left: size.width * .12,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Jalynn Brown.png',
              title: 'World Imperial Junior Teen',
            ),
          ),
          Positioned(
            bottom: size.height * .23,
            left: size.width * .25,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Teagan Fields.png',
              title: 'World Imperial Preteen',
            ),
          ),

          //Right Side
          Positioned(
            bottom: size.height * .1,
            right: size.width * .07,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Lilly Parker.png',
              title: 'World Imperial Teen',
              isOnRightSide: true,
            ),
          ),
          Positioned(
            top: size.height * .1,
            right: size.width * .12,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Yolanda Grayson.png',
              title: 'World Imperial Ms.',
              isOnRightSide: true,
            ),
          ),
          Positioned(
            bottom: size.height * .23,
            right: size.width * .25,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Lauren Madison.png',
              title: 'World Imperial Miss',
              isOnRightSide: true,
            ),
          ),

          //Center
          Positioned(
            bottom: size.height * .05,
            right: size.width * .45,
            child: const WinnerDisplayItem(
              image: 'assets/images/international winners/Diane Boyd.png',
              title: 'World Imperial Classic Ms.',
              isCenter: true,
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
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
                        fontSize: 33,
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
        ],
      ),
    );
  }
}
