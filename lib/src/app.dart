import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_routes.dart';
import '../screens/About/about_screen.dart';
import '../screens/Contact/contactScreen.dart';
import '../screens/Enter Online/registration_screen.dart';
import '../screens/home/home_screen.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            primaryColor: AppColors.mainBlue,
            scaffoldBackgroundColor: AppColors.scaffoldBg,
            textTheme: TextTheme(
              headline1: GoogleFonts.nanumMyeongjo().copyWith(fontSize: 90),

              headline2: GoogleFonts.alexBrush()
                  .copyWith(fontSize: 140, color: AppColors.mainBlue),

              // headline2: GoogleFonts.euphoriaScript()
              // .copyWith(fontSize: 140, color: AppColors.mainBlue),

              // headline2: GoogleFonts.clickerScript()
              // .copyWith(fontSize: 140, color: AppColors.mainBlue),

              //  headline2: GoogleFonts.inspiration()
              // .copyWith(fontSize: 140, color: AppColors.mainBlue),
              headline3: GoogleFonts.rubik()
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w500),
              bodyText2: GoogleFonts.nunitoSans()
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              bodyText1: GoogleFonts.nanumMyeongjo()
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          // darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          home: const HomeScreen(),
          // home: const LoginSignupScreen(),
          // home: const TopLevel(),
          // home: const LandingScreen(),
          // home: const UserProfile(),

          getPages: [
            //Authentication routes
            GetPage(
              name: AppRoutes.aboutRoute,
              page: () => const AboutScreen(),
              title: 'Learn About Us',
            ),
            GetPage(
              name: AppRoutes.contactRoute,
              page: () => const ContactScreen(),
              title: 'Get In Touch',
            ),
            GetPage(
              name: AppRoutes.registerRoute,
              page: () => const RegistrationScreen(),
              title: 'Enter',
            ),
          ],
        );
      },
    );
  }
}
