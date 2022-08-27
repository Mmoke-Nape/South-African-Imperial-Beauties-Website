import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mother_international_comp_website/constants/app_colors.dart';
import 'package:mother_international_comp_website/screens/home/widgets/home_screen_1.dart';
import 'package:mother_international_comp_website/screens/home/widgets/home_screen_2.dart';
import 'package:mother_international_comp_website/screens/home/widgets/winner_display_item.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Center(
          child: Text(
            'HOME',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.mainBlue, fontWeight: FontWeight.bold),
          ),
        ),
        leadingWidth: size.width * .2,
        centerTitle: true,
        title: SizedBox(
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
                'Enter Online',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                right: size.width * .1,
              ),
              child: Text(
                'Contact Us',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.scaffoldBg,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeScreen1(),
              const HomeScreen2(),
              const SizedBox(height: 50),
              Container(
                width: size.width,
                height: 100,
                color: AppColors.mainBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
