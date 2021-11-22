import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:niger_delta_unity_app/screens/home/home.dart';
import 'package:niger_delta_unity_app/state/state_manager.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  late Widget currentScreen;
  final _controller = Get.find<StateManager>();
  DateTime pre_backpress = DateTime.now();

  final timegap = DateTime.now().difference(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 4);
        pre_backpress = DateTime.now();
        if (cantExit) {
          // Fluttertoast.showToast(
          //     msg: "Press again to exit",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 3,
          //     backgroundColor: Colors.grey[800],
          //     textColor: Colors.white,
          // fontSize: 16.0);

          return false; // false will do nothing when back press
        } else {
          _controller.setIsLoading(true);
          if (Platform.isAndroid) {
            exit(0);
          } else if (Platform.isIOS) {}
          return true;
        }
      },
      child: Obx(() {
        return LoadingOverlayPro(
          isLoading: _controller.isLoading.value,
          child: Scaffold(
            body: PageStorage(
              child: _controller.currentScreen,
              bucket: _pageStorageBucket,
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        _controller.selectTab(
                            const Home(), _controller.pageKeys[0], 0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/home_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: 4,
                              height: 4,
                              color: Constants.accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/news_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const Text(
                            'News',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: 4,
                              height: 4,
                              color: Constants.accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/projects_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const Text(
                            'Projects',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: 4,
                              height: 4,
                              color: Constants.accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/directories_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const Text(
                            'Directory',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: 4,
                              height: 4,
                              color: Constants.accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/account_icon.svg',
                            width: 18,
                            height: 18,
                          ),
                          const Text(
                            'Account',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          ClipOval(
                            child: Container(
                              width: 4,
                              height: 4,
                              color: Constants.accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
