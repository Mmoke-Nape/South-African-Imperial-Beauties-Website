import 'package:flutter/material.dart';
import 'package:mother_international_comp_website/responsive/responsive.dart';
import 'package:mother_international_comp_website/widgets/on_hover.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      // height: 100,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Image.asset('assets/images/logo/logo full.png', height: 60),
          const SizedBox(height: 20),
          Flex(
            direction:
                Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© South African Imperial Beauties - 2022 | Developed by ',
                style: TextStyle(
                    color: AppColors.mainBlue,
                    fontSize: Responsive.isMobile(context) ? 14 : null),
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
              GestureDetector(
                onTap: () => _launchUrl('https://mmoke-nape.github.io/'),
                child: OnHover(
                  isNav: false,
                  builder: (hover) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        'Mmoke Nape',
                        style: TextStyle(
                          color: hover ? Colors.black87 : AppColors.mainBlue,
                          fontSize: Responsive.isMobile(context) ? 14 : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void _launchUrl(String url) async {
  // ignore: deprecated_member_use
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: true,
    enableJavaScript: true,
  )) throw 'Could not launch URL';
}
