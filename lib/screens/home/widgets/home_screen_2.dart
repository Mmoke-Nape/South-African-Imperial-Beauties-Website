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
              image:
                  'http://nebula.wsimg.com/eacc2ba1d0996e2cc19f21d0eef3ebd2?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
              title: 'World Imperial Junior Miss',
            ),
          ),
          Positioned(
            top: Responsive.isMobile(context) ? 70 : 0,
            left: Responsive.isMobile(context)
                ? size.width * .09
                : size.width * .12,
            child: const WinnerDisplayItem(
              image:
                  'http://nebula.wsimg.com/e81d877b0e3d4fbb1f5b810578a6a9e1?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
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
              image:
                  'http://nebula.wsimg.com/dc3567de10cbeb49cbcf842c2ec9b067?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
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
              image:
                  'http://nebula.wsimg.com/d9e4ef5bbef93259f1aacd4d084de616?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
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
              image:
                  'http://nebula.wsimg.com/21dc8afcc46fbf5517f0cec0fa2350a5?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
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
              image:
                  'http://nebula.wsimg.com/7cfea4334167ee58ce0423e7ee7c8f8a?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
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
              image:
                  'http://nebula.wsimg.com/300fe8f9dd453372c57c5db0a779e963?AccessKeyId=15269ACCC4C8BB742AF7&disposition=0&alloworigin=1',
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
