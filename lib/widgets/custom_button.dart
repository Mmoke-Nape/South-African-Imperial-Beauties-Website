import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

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
      child: Container(
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
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColors.mainBlue,
                  fontWeight: FontWeight.bold,
                  // fontSize: 22,
                ),
          ),
        ),
      ),
    );
  }
}
