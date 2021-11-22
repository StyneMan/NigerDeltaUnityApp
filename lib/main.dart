import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niger_delta_unity_app/screens/landing/landing.dart';
import 'package:niger_delta_unity_app/state/state_manager.dart';
import 'package:niger_delta_unity_app/utility/theme/apptheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _stateController = Get.put(StateManager());

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
