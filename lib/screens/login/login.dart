import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:niger_delta_unity_app/forms/login/login_form.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            height: 380,
            child: LoginForm(),
          ),
        );
        // showMaterialModalBottomSheet(
        //   expand: false,
        //   context: context,
        //   // topRadius: const Radius.circular(24),
        //   backgroundColor: Colors.white,
        //   builder: (context) => const LoginForm(),
        // );
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
          Future.delayed(const Duration(milliseconds: 100), () {
            Get.back();
            print('OBEJEAS');
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
                // color: Colors.lightBlueAccent,
                // allowDrawingOutsideViewBox: true,
              ),
              // Container(
              //   width: double.infinity,
              //   height: double.infinity,
              //   // color: const Color(0x750C0C77),
              // ),
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
                            // Container(
                            //   padding: const EdgeInsets.all(10.0),
                            //   width: double.infinity,
                            //   decoration: const BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.only(
                            //       topRight: Radius.circular(24),
                            //       topLeft: Radius.circular(24),
                            //     ),
                            //   ),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     crossAxisAlignment: CrossAxisAlignment.stretch,
                            //     children: const [
                            //       Text(
                            //         'Login to Continue',
                            //       ),
                            //       SizedBox(
                            //         height: 18.0,
                            //       ),
                            //       // LoginForm(),
                            //     ],
                            //   ),
                            // ),
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
