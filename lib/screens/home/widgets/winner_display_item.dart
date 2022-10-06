import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../responsive/responsive.dart';

class WinnerDisplayItem extends StatelessWidget {
  const WinnerDisplayItem({
    Key? key,
    required this.title,
    required this.image,
    this.isOnRightSide = false,
    this.isCenter = false,
  }) : super(key: key);
  final String title;
  final String image;
  final bool isOnRightSide;
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: isOnRightSide
              ? Responsive.isMobile(context)
                  ? 15
                  : 25
              : Responsive.isMobile(context)
                  ? -15
                  : -25,
          top: Responsive.isMobile(context) ? 15 : 25,
          child: Container(
            height: Responsive.isMobile(context)
                ? size.height * .25
                : size.height * .35,
            width: isCenter
                ? Responsive.isMobile(context)
                    ? size.width * .3 + 25
                    : size.width * .12 + 50
                : Responsive.isMobile(context)
                    ? size.width * .3
                    : size.width * .12,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.mainBlue, width: 2),
            ),
          ),
        ),
        Container(
          height: Responsive.isMobile(context)
              ? size.height * .25
              : size.height * .35,
          width:
              Responsive.isMobile(context) ? size.width * .3 : size.width * .12,
          color: Colors.white,
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: isCenter
              ? -25
              : isOnRightSide
                  ? -10
                  : 10,
          bottom: 20,
          child: Container(
            // height: 40,
            // width: 100,
            padding: EdgeInsets.symmetric(
                vertical: Responsive.isMobile(context) ? 5 : 10,
                horizontal: Responsive.isMobile(context) ? 10 : 20),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainBlue, width: 2),
                color: Colors.white),
            child: Text(title,
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 14 : null)),
          ),
        ),
      ],
    );
  }
}
