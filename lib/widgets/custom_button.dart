import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import 'on_hover.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: OnHover(
        isNav: false,
        builder: (hover) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            // padding: const EdgeInsets.symmetric(
            //     vertical: 10, horizontal: 20),
            height: 80,
            width: size.width * .12,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainBlue,
              ),
              color: hover ? AppColors.mainBlue : Colors.white,
            ),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: hover ? Colors.white : AppColors.mainBlue,
                      fontWeight: FontWeight.bold,
                      // fontSize: 22,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
