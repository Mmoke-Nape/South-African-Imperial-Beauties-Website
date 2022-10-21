import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mother_international_comp_website/constants/app_colors.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';
import 'package:mother_international_comp_website/screens/home/widgets/home_screen_1.dart';
import 'package:mother_international_comp_website/screens/home/widgets/home_screen_2.dart';
import 'package:mother_international_comp_website/screens/home/widgets/winner_display_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../responsive/responsive.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/footer.dart';
import '../../widgets/on_hover.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var hoverColor = Colors.black;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      drawer: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        color: Colors.white,
        width: size.width * .7,
        height: size.height,
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo/logo full.png',
              // height: size.height * .3,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: size.height * .2),
            Container(
              height: 70,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.mainBlue),
                ),
              ),
              child: Center(
                child: Text(
                  'Home',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.mainBlue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 70,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.registerRoute),
                  child: Text(
                    'Enter Online',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Center(
          child: Responsive.isMobile(context)
              ? null
              : Text(
                  'HOME',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.mainBlue, fontWeight: FontWeight.bold),
                ),
        ),
        leadingWidth: size.width * .2,
        centerTitle: true,
        title: Responsive.isMobile(context)
            ? Image.asset(
                'assets/images/logo/logo.png',
                height: 60,
              )
            : Image.asset(
                'assets/images/logo/logo full.png',
                height: 60,
              ),
        actions: [
          Center(
            child: Responsive.isMobile(context)
                ? IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu, color: AppColors.mainBlue),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      right: size.width * .1,
                    ),
                    child: InkWell(
                      onHover: (value) => setState(() {
                        hoverColor = AppColors.mainBlue;
                      }),
                      onTap: () => Get.toNamed(AppRoutes.registerRoute),
                      hoverColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Enter Online',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: hoverColor)),
                      ),
                    ),
                  ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.scaffoldBg,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HomeScreen1(),
            HomeScreen2(),
            SizedBox(height: 50),
            Footer(),
          ],
        ),
      ),
    );
  }
}
