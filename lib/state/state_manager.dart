import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niger_delta_unity_app/screens/home/home.dart';

class StateManager extends GetxController {
  var isAppClosed = false;
  var isLoading = false.obs;
  var shouldShowBottomSheet = false.obs;
  var accessToken = "";
  var imageCropped;

  Widget currentScreen = const Home();

  var currentPage = "Home";
  List<String> pageKeys = [
    "Home",
    "News",
    "Projects",
    "Directories",
    "Account"
  ];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "News": GlobalKey<NavigatorState>(),
    "Projects": GlobalKey<NavigatorState>(),
    "Directories": GlobalKey<NavigatorState>(),
    "Account": GlobalKey<NavigatorState>(),
  };

  var selectedIndex = 0.obs;

  void setAccessToken(String token) {
    accessToken = token;
  }

  String getAccessToken() => accessToken;

  void selectTab(var currPage, String tabItem, int index) {
    if (tabItem == currentPage) {
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
      currentScreen = currPage;
    } else {
      currentPage = pageKeys[index];
      selectedIndex.value = index;
      currentScreen = currPage;
    }
  }

  void setIsLoading(bool state) {
    isLoading.value = state;
  }

  void setShouldShowBottomSheet(bool state) {
    shouldShowBottomSheet.value = state;
  }

  void setImageCropped(var croppedImage) {
    imageCropped = croppedImage;
  }

  // void resetAll() {
  //   verifyCode = 0.obs;
  //   createAccount = 0.obs;
  //   login = 0.obs;
  // }
}
