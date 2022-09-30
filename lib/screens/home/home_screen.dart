import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mother_international_comp_website/constants/app_colors.dart';
import 'package:mother_international_comp_website/screens/home/widgets/home_screen_1.dart';
import 'package:mother_international_comp_website/screens/home/widgets/home_screen_2.dart';
import 'package:mother_international_comp_website/screens/home/widgets/winner_display_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../responsive/responsive.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/footer.dart';
import '../../widgets/on_hover.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Center(
          child: Responsive.isMobile(context)
              ? const FlutterLogo(size: 20)
              : Text(
                  'HOME',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.mainBlue, fontWeight: FontWeight.bold),
                ),
        ),
        leadingWidth: size.width * .2,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo/logo full.png',
          height: 60,
        ),
        actions: [
          Center(
            child: Responsive.isMobile(context)
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.menu, color: Colors.black),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      right: size.width * .1,
                    ),
                    child: Text('Enter Online',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.scaffoldBg,
      ),
      body: Scrollbar(
        thumbVisibility: Responsive.isMobile(context) ? false : true,
        thickness: 15,

        // hoverThickness: 20,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HomeScreen1(),
              HomeScreen2(),
              SizedBox(height: 50),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
