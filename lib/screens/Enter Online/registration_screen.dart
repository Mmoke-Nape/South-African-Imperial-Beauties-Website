import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: Center(
            child: Text('HOME', style: Theme.of(context).textTheme.bodyText1),
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
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.mainBlue, fontWeight: FontWeight.bold),
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
        body: Center(
          child: Text('Registration Screen'),
        ));
  }
}
