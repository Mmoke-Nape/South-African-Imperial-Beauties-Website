import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mother_international_comp_website/constants/app_routes.dart';
import 'package:mother_international_comp_website/responsive/responsive.dart';
import 'package:mother_international_comp_website/screens/Enter%20Online/registration_form.dart';
import 'package:mother_international_comp_website/widgets/footer.dart';

import '../../constants/app_colors.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _key = GlobalKey();
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
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.homeRoute);
                  },
                  child: Text(
                    'Home',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
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
                  'Enter Online',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColors.mainBlue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        // leading: Center(
        //   child: Responsive.isMobile(context)
        //       ? const FlutterLogo(size: 20)
        //       : Text('HOME', style: Theme.of(context).textTheme.bodyText1),
        // ),
        leadingWidth: size.width * .2,
        centerTitle: true,
        title: Responsive.isMobile(context)
            ? Image.asset(
                'assets/images/logo/logo.png',
                height: 60,
              )
            : SizedBox(
                width: size.width * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      // onHover: (value) => setState(() {
                      //   hoverColor = AppColors.mainBlue;
                      // }),
                      onTap: () => Get.toNamed(AppRoutes.homeRoute),
                      hoverColor: Colors.transparent,
                      child: Text(
                        'Home',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(AppRoutes.homeRoute),
                      hoverColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/logo/logo full.png',
                        height: 60,
                      ),
                    ),
                    Text(
                      'Enter Online',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors.mainBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
                  : null),
        ],
        elevation: 0,
        backgroundColor: AppColors.scaffoldBg,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              // height: size.height,
              padding: EdgeInsets.only(
                  left: Responsive.isMobile(context) ? 20 : 90,
                  right: Responsive.isMobile(context) ? 20 : 100,
                  bottom: Responsive.isMobile(context) ? 10 : 50),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.mainBlue,
                  Colors.white,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Entry Form',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            // color: AppColors.mainBlue,
                            color: Colors.white,
                            fontSize: Responsive.isMobile(context) ? 32 : 60,
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Who can enter?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        // color: AppColors.mainBlue,
                        fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: size.width * .7,
                      child: const Text(
                        'This competition is open to females of any race, creed, or culture of the age of 3 to 50+. Age as on 01 January 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Dates?',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: Colors.white,
                        // color: AppColors.mainBlue,
                        fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: size.width * .7,
                      child: const Text(
                        'Entries open: 30 August 2022\nCompetition date: April 2023',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: size.width * .7,
                      child: const Text(
                        'Please read through all the competition rules at the bottom of the page before entering',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Responsive.isMobile(context)
                        ? Axis.vertical
                        : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              SizedBox(
                                width: Responsive.isMobile(context)
                                    ? null
                                    : size.width * .4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Age Categories',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.white,
                                                    // color: AppColors.mainBlue,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Little Miss 4-6',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Jnr Miss 7-9',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Preteen 10-12',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Jnr Teen 13-15',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Teen 16-19',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Miss 20-29',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Miss Ice 30-49',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Classic Ms 50+',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Prizes',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    // color: AppColors.mainBlue,
                                                    color: Colors.white,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'GRAND PRIZE:',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Junior Overall Supreme (4-12) & Senior Overall Supreme (13-50) will recive a FULLY PAID TRIP OVERSEAS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          const Text(
                                            'TOP 3:',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Category winner, 1st princess and 2nd princess will recive an opportunity to compete overseas for the international title',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: Responsive.isMobile(context)
                                    ? null
                                    : size.width * .4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Gala Night',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    color: Colors.white,
                                                    // color: AppColors.mainBlue,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Gala dinner',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Spectacular Crowning',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Opening performance by the finalists',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'We Supply',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    // color: AppColors.mainBlue,
                                                    color: Colors.white,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Offical T-Shirt',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Carry bag for all finalists',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Official finalist sash',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                width: Responsive.isMobile(context)
                                    ? null
                                    : size.width * .4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Entry Fee',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    // color: AppColors.mainBlue,
                                                    color: Colors.white,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'R500',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Compete In',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    // color: AppColors.mainBlue,
                                                    color: Colors.white,
                                                    fontSize: 30),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Fun Fashion, Interview & Evening wear',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Contact Information',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              // color: AppColors.mainBlue,
                                              color: Colors.white,
                                              fontSize: 30),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Gladys 082 378 3843 / 065 827 4892',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const RegistrationForm(),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'World Imperial Beauties South Africa Rules:',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          // color: AppColors.mainBlue,
                          // color: Colors.white,
                          fontSize: Responsive.isMobile(context) ? 32 : 50,
                        ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: size.width * .8,
                    child: const Text(
                      '''1. The pageant is open to persons residing in any part of South Africa 

2. A registration fee of R 500 to be paid before a model can be considered as a finalist 

4. You are required to raise a compulsory sponsorship fee of R3500

5. Accommodation and travel fees will be for your account.

6. Hair and make up will be arranged but will be on your account

8. Judges’ decision is final, and no correspondence will be entered into.

9. By entering each contestant commits herself to the following:
      • Compulsory sponsorship fee of R3 500
      • Sell 3 x Gala tickets for R250 each (R150 for children under 10 years-include dinner) If the tickets are not sold the contestant must raise the same value additionally and submit along with the sponsorship.
      • R100 for corier of the sashes      

10. All finalists receive finalist sashes to be used discreetly and worn with pride. Any abuse will lead to disqualification.

11. No fees paid are transferable or refundable nor does it cover the cancellation fee in such event the cancellation fee is R1500.

12. The overseas grand supreme prize will only materialize when there are more than 20 participants per division (4-12 & 13-50+). 

13. Payment Plan: (Strictly) This include Sponsorship Fee R3 500, R750 for tickets & dinner and R100.
               Payment 1: R1000 (October)
               Payment 2: R1500 (November)
               Payment 3: R1500 (December)
               Payment 4: R350 (January 2023)                 
14. Cash payout are dependent on the number of contestants per category. Cash payments will be done after a month after the competition.
2b). The total R4350 will include:
        - 0pening number dress
        - T-shirt.
        - finalist Sash
        - All courier costs

Please make payments immediate inter banking transaction for payments.

All rules and regulations need to be complied with, to avoid disqualification and a deduction of your points.

Closing date is 15 DECEMBER 2022.

NO LATE ENTRIES WILL BE ACCEPTED.

Under no circumstances will any refunds be made.

The judge’s decision is final; no correspondence will be entered into.

No communication with judges, before, during or after the competition will be tolerated. No parents or spectators will be permitted to interfere on any level.

OVERALL prizes are not transferable or redeemable for cash.

No make-up will be allowed under 12 years, only lip gloss, we are looking for a natural young girl.

''',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            // const SizedBox(height: 50),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
