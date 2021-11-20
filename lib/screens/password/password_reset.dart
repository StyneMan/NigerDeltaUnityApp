import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/forms/password/password_reset.dart';
import 'package:niger_delta_unity_app/forms/signup/signup_form.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  bool _shouldShowSheet = true;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_shouldShowSheet) {
        showCupertinoModalBottomSheet(
          expand: false,
          enableDrag: false,
          useRootNavigator: true,
          barrierColor: Colors.transparent,
          elevation: 0.0,
          context: context,
          topRadius: const Radius.circular(32),
          backgroundColor: Colors.white,
          builder: (context) => const SizedBox(
            height: 210,
            child: PasswordResetForm(),
          ),
        );
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
          Future.delayed(const Duration(milliseconds: 100), () {
            Get.back();
          });
        },
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        elevation: 1000,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: Container(
          color: Constants.primaryColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/pattern.png',
                fit: BoxFit.cover,
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 36,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/logo_white.png'),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  const Text(
                                    'Niger Delta Unity App',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                top: 10,
                bottom: 10,
                left: 10,
                right: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
