import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/features/authentication/screens/signup/verify_email.dart';
import 'package:project/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme, // Use the correct reference
      darkTheme: TAppTheme.darkTheme, // You can define your dark theme here
      home: const OnBoardingScreen(),
    );
  }
}