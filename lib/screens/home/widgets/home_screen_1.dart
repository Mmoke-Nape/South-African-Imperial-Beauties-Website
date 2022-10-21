import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_routes.dart';
import '../../../responsive/responsive.dart';
import '../../../widgets/custom_button.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 70,
      width: size.width,
      child: Stack(
        children: [
          Positioned(
            right: Responsive.isMobile(context) ? null : 0,
            left: Responsive.isMobile(context) ? -size.width * .85 : null,
            top: 0,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/crown.png',
                height: size.height * .82,
                fit: BoxFit.contain,
              ),
            ),
            // child: Stack(children: <Widget>[
            //   Container(
            //     decoration: BoxDecoration(
            //       color: Colors.transparent,
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: AssetImage(
            //           'assets/images/crown.png',
            //         ),
            //       ),
            //     ),
            //     height: size.height * .82,
            //   ),
            //   Container(
            //     height: size.height * .82,
            //     decoration: BoxDecoration(
            //         // color: Colors.white,
            //         gradient: LinearGradient(
            //             begin: FractionalOffset.topCenter,
            //             end: FractionalOffset.bottomCenter,
            //             colors: [
            //           Colors.grey.withOpacity(0.0),
            //           Colors.black,
            //         ],
            //             stops: [
            //           0.0,
            //           1.0
            //         ])),
            //   )
            // ]),

            // ColorFiltered(
            //   colorFilter: ColorFilter.mode(
            //       Colors.red.withOpacity(0.4), BlendMode.srcOver),
            //   child: Image.asset(
            //     'assets/images/crown.png',
            //     height: size.height * .82,
            //     fit: BoxFit.fitHeight,
            //   ),
            // ),
          ),
          Positioned(
            left: Responsive.isMobile(context)
                ? size.width * .1
                : size.width * .15,
            top: Responsive.isMobile(context)
                ? size.height * .1
                : size.height * .2,
            child: Text(
              'World',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.black87,
                  fontSize: Responsive.isMobile(context) ? 50 : null),
            ),
          ),
          Positioned(
            left: Responsive.isMobile(context)
                ? size.width * .03
                : size.width * .2,
            top: Responsive.isMobile(context)
                ? size.height * .14
                : size.height * .26,
            child: Text(
              'Imperial Beauties',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: Responsive.isMobile(context) ? 55 : null),
            ),
          ),
          Positioned(
            left: Responsive.isMobile(context)
                ? size.width * .14
                : size.width * .23,
            top: Responsive.isMobile(context)
                ? size.height * .2
                : size.height * .4,
            child: Text(
              'SOUTH AFRICA',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.black87,
                  fontSize: Responsive.isMobile(context) ? 40 : 80),
            ),
          ),
          Positioned(
            left: Responsive.isMobile(context)
                ? size.width * .08
                : size.width * .17,
            top: Responsive.isMobile(context)
                ? size.height * .25
                : size.height * .5,
            child: Text(
              'SCHOLARSHIP PAGEANT',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.black87,
                  fontSize: Responsive.isMobile(context) ? 23 : 33,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            left: Responsive.isMobile(context)
                ? size.width * .1
                : size.width * .13,
            bottom: Responsive.isMobile(context)
                ? size.height * .25
                : size.height * .20,
            child: Center(
              child: Flex(
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   margin: const EdgeInsets.only(top: 10),
                  //   color: AppColors.mainBlue,
                  //   height: 1.5,
                  //   width: size.width * .1,
                  // ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: size.width * .05),
                  SizedBox(
                    width: Responsive.isMobile(context)
                        ? size.width * .8
                        : size.width * .3,
                    child: Text(
                      'South African Imperial Beauties is a celebration of womanhood through an equal opportunity platform for women to showcase their talent and beauty to the world.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 20 : null),
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: size.width * .05),
                  if (Responsive.isMobile(context)) const SizedBox(height: 30),
                  CustomButton(
                    press: () => Get.toNamed(AppRoutes.registerRoute),
                    title: 'JOIN US',
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
