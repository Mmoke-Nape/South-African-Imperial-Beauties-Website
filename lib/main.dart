import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          measurementId: "G-CX3L8BDW71",
          storageBucket: "sa-imperial-beauties.appspot.com",
          authDomain: "sa-imperial-beauties.firebaseapp.com",
          apiKey: "AIzaSyDX6au5-Kz6g-1X254CHhAWpJXrBHWnsHY",
          appId: "1:845033256832:web:051d2748d70e9df0d5b365",
          messagingSenderId: "845033256832",
          projectId: "sa-imperial-beauties"));
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
