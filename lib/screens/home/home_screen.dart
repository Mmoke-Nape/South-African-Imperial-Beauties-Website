import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mother_international_comp_website/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height - 70,
                  width: size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        right: size.width * .1,
                        top: size.height * .05,
                        child: Image.asset(
                          'images/models/white_model1.png',
                          height: size.height * .85,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        left: size.width * .15,
                        top: size.height * .2,
                        child: Text(
                          'SOUTH AFRICAN',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.black87),
                        ),
                      ),
                      Positioned(
                        left: size.width * .2,
                        top: size.height * .26,
                        child: Text(
                          'Imperial Beauties',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(),
                        ),
                      ),
                      Positioned(
                        left: size.width * .17,
                        top: size.height * .45,
                        child: Text(
                          'SCHOLARSHIP PAGEANT',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.black87,
                                  fontSize: 33,
                                  fontWeight: FontWeight.w500),
                        ),
                      ),
                      Positioned(
                        left: size.width * .13,
                        bottom: size.height * .20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   margin: const EdgeInsets.only(top: 10),
                            //   color: AppColors.mainBlue,
                            //   height: 1.5,    
                            //   width: size.width * .1,
                            // ),
                            SizedBox(width: size.width * .05),
                            SizedBox(
                              width: size.width * .3,
                              child: const Text(
                                'South African Imperial Beauties is a celebration of womanhood through an equal opporitinty platform for women to showcase their talent and beauty to the world.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: size.width * .05),
                            Container(
                              // padding: const EdgeInsets.symmetric(
                              //     vertical: 10, horizontal: 20),
                              height: 80,
                              width: size.width * .12,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.mainBlue,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'JOIN US',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColors.mainBlue,
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 22,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                Text(
                  'About',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                FlutterLogo(
                  size: 20,
                ),
                Text(
                  'Application',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Text(
            'Contact Us',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
