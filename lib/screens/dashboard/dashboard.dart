import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:niger_delta_unity_app/screens/account/account.dart';
import 'package:niger_delta_unity_app/screens/directories/directories.dart';
import 'package:niger_delta_unity_app/screens/home/home.dart';
import 'package:niger_delta_unity_app/screens/news/news.dart';
import 'package:niger_delta_unity_app/screens/projects/projects.dart';
import 'package:niger_delta_unity_app/state/state_manager.dart';
import 'package:niger_delta_unity_app/utility/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  Widget currentScreen = Home();
  int _currentIndex = 0;
  final _controller = Get.find<StateManager>();
  PersistentTabController _tabController =
      PersistentTabController(initialIndex: 0);

  DateTime pre_backpress = DateTime.now();

  final timegap = DateTime.now().difference(DateTime.now());

  @override
  void initState() {
    super.initState();
    // _tabController.jumpToTab(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 4);
        pre_backpress = DateTime.now();
        if (cantExit) {
          Fluttertoast.showToast(
              msg: "Press again to exit",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey[800],
              textColor: Colors.white,
              fontSize: 16.0);

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
            body: PersistentTabView(
              context,
              controller: _tabController,
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor:
                  Constants.primaryColor, // Default is Colors.white.
              handleAndroidBackButtonPress: false, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: const NavBarDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle
                  .style3, // Choose the nav bar style with this property.
            ),
            // body: PageStorage(
            //   child: currentScreen,
            //   bucket: _pageStorageBucket,
            // ),
            // bottomNavigationBar: BottomAppBar(
            //   child: Container(
            //     height: 60,
            //     width: double.infinity,
            //     padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
            //     decoration: const BoxDecoration(
            //       color: Constants.primaryColor,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(24),
            //         topRight: Radius.circular(24),
            //       ),
            //     ),
            //     // child: Row(
            //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     //   crossAxisAlignment: CrossAxisAlignment.center,
            //     //   children: <Widget>[
            //     //     Expanded(
            //     //       child: MaterialButton(
            //     //         onPressed: () {
            //     //           setState(() {
            //     //             currentScreen = Home();
            //     //             _currentIndex = 0;
            //     //           });
            //     //           // _controller.selectTab(
            //     //           //     Home(), _controller.pageKeys[0], 0);
            //     //         },
            //     //         child: Column(
            //     //           mainAxisAlignment: MainAxisAlignment.start,
            //     //           crossAxisAlignment: CrossAxisAlignment.center,
            //     //           children: <Widget>[
            //     //             SvgPicture.asset(
            //     //               'assets/images/home_icon.svg',
            //     //               width: 18,
            //     //               height: 18,
            //     //             ),
            //     //             const Text(
            //     //               'Home',
            //     //               style: TextStyle(
            //     //                 fontSize: 10,
            //     //                 color: Colors.white,
            //     //               ),
            //     //             ),
            //     //             ClipOval(
            //     //               child: Container(
            //     //                 width: 4,
            //     //                 height: 4,
            //     //                 color: _currentIndex == 0
            //     //                     ? Constants.accentColor
            //     //                     : Colors.transparent,
            //     //               ),
            //     //             )
            //     //           ],
            //     //         ),
            //     //         minWidth: 40,
            //     //       ),
            //     //     ),
            //     //     Expanded(
            //     //       child: MaterialButton(
            //     //         onPressed: () {
            //     //           setState(() {
            //     //             currentScreen = News();
            //     //             _currentIndex = 1;
            //     //           });
            //     //         },
            //     //         child: Column(
            //     //           mainAxisAlignment: MainAxisAlignment.start,
            //     //           crossAxisAlignment: CrossAxisAlignment.center,
            //     //           children: <Widget>[
            //     //             SvgPicture.asset(
            //     //               'assets/images/news_icon.svg',
            //     //               width: 18,
            //     //               height: 18,
            //     //             ),
            //     //             const Text(
            //     //               'News',
            //     //               style: TextStyle(
            //     //                 fontSize: 10,
            //     //                 color: Colors.white,
            //     //               ),
            //     //             ),
            //     //             ClipOval(
            //     //               child: Container(
            //     //                 width: 4,
            //     //                 height: 4,
            //     //                 color: _currentIndex == 1
            //     //                     ? Constants.accentColor
            //     //                     : Colors.transparent,
            //     //               ),
            //     //             )
            //     //           ],
            //     //         ),
            //     //         minWidth: 40,
            //     //       ),
            //     //     ),
            //     //     Expanded(
            //     //       child: MaterialButton(
            //     //         onPressed: () {
            //     //           setState(() {
            //     //             currentScreen = Projects();
            //     //             _currentIndex = 2;
            //     //           });
            //     //         },
            //     //         child: Column(
            //     //           mainAxisAlignment: MainAxisAlignment.start,
            //     //           crossAxisAlignment: CrossAxisAlignment.center,
            //     //           children: <Widget>[
            //     //             SvgPicture.asset(
            //     //               'assets/images/projects_icon.svg',
            //     //               width: 18,
            //     //               height: 18,
            //     //             ),
            //     //             const Text(
            //     //               'Projects',
            //     //               style: TextStyle(
            //     //                 fontSize: 10,
            //     //                 color: Colors.white,
            //     //               ),
            //     //             ),
            //     //             ClipOval(
            //     //               child: Container(
            //     //                 width: 4,
            //     //                 height: 4,
            //     //                 color: _currentIndex == 2
            //     //                     ? Constants.accentColor
            //     //                     : Colors.transparent,
            //     //               ),
            //     //             )
            //     //           ],
            //     //         ),
            //     //         minWidth: 40,
            //     //       ),
            //     //     ),
            //     //     Expanded(
            //     //       child: MaterialButton(
            //     //         onPressed: () {
            //     //           setState(() {
            //     //             currentScreen = Directories();
            //     //             _currentIndex = 3;
            //     //           });
            //     //         },
            //     //         child: Column(
            //     //           mainAxisAlignment: MainAxisAlignment.start,
            //     //           crossAxisAlignment: CrossAxisAlignment.center,
            //     //           children: <Widget>[
            //     //             SvgPicture.asset(
            //     //               'assets/images/directories_icon.svg',
            //     //               width: 18,
            //     //               height: 18,
            //     //             ),
            //     //             const Text(
            //     //               'Directory',
            //     //               style: TextStyle(
            //     //                 fontSize: 10,
            //     //                 color: Colors.white,
            //     //               ),
            //     //             ),
            //     //             ClipOval(
            //     //               child: Container(
            //     //                 width: 4,
            //     //                 height: 4,
            //     //                 color: _currentIndex == 3
            //     //                     ? Constants.accentColor
            //     //                     : Colors.transparent,
            //     //               ),
            //     //             )
            //     //           ],
            //     //         ),
            //     //         minWidth: 40,
            //     //       ),
            //     //     ),
            //     //     Expanded(
            //     //       child: MaterialButton(
            //     //         onPressed: () {
            //     //           // print('hjjh jj');
            //     //           // _controller.selectTab(
            //     //           //     Account(), _controller.pageKeys[4], 4);
            //     //           setState(() {
            //     //             currentScreen = Account();
            //     //             _currentIndex = 4;
            //     //           });
            //     //         },
            //     //         child: Column(
            //     //           mainAxisAlignment: MainAxisAlignment.start,
            //     //           crossAxisAlignment: CrossAxisAlignment.center,
            //     //           children: <Widget>[
            //     //             SvgPicture.asset(
            //     //               'assets/images/account_icon.svg',
            //     //               width: 18,
            //     //               height: 18,
            //     //             ),
            //     //             const Text(
            //     //               'Account',
            //     //               style: TextStyle(
            //     //                 fontSize: 10,
            //     //                 color: Colors.white,
            //     //               ),
            //     //             ),
            //     //             ClipOval(
            //     //               child: Container(
            //     //                 width: 4,
            //     //                 height: 4,
            //     //                 color: _currentIndex == 4
            //     //                     ? Constants.accentColor
            //     //                     : Colors.transparent,
            //     //               ),
            //     //             )
            //     //           ],
            //     //         ),
            //     //         minWidth: 40,
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //   ),
            // ),
          ),
        );
      }),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/home_icon.svg',
          width: 18,
          height: 18,
        ),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/news_icon.svg',
          width: 18,
          height: 18,
        ),
        title: ("News"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/projects_icon.svg',
          width: 18,
          height: 18,
        ),
        title: ("Projects"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/directories_icon.svg',
          width: 18,
          height: 18,
        ),
        title: ("Directories"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/images/account_icon.svg',
          width: 18,
          height: 18,
        ),
        title: ("Account"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return const [
      Home(),
      News(),
      Projects(),
      Directories(),
      Account(),
    ];
  }
}
