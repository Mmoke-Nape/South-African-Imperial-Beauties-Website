import 'package:flutter/material.dart';

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
          Text(
            'Contact Us',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
