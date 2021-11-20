import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niger_delta_unity_app/screens/landing/landing.dart';
import 'package:niger_delta_unity_app/utility/theme/apptheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NDUA',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LandingPage(),
    );
  }
}
