import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

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
          left: isOnRightSide ? 25 : -25,
          top: 25,
          child: Container(
            height: size.height * .35,
            width: isCenter ? size.width * .12 + 50 : size.width * .12,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.mainBlue, width: 2),
            ),
          ),
        ),
        Container(
          height: size.height * .35,
          width: size.width * .12,
          color: Colors.white,
          child: Image.asset(
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainBlue, width: 2),
                color: Colors.white),
            child: Text(title),
          ),
        ),
      ],
    );
  }
}
