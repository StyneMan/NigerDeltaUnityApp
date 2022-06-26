import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niger_delta_unity_app/screens/home/home.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StateManager extends GetxController {
  var isAppClosed = false;
  var isLoading = false.obs;
  var shouldShowBottomSheet = false.obs;
  var accessToken = "";
  var imageCropped;
  var adsData = [].obs;
  final _tabController = PersistentTabController(initialIndex: 0);

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

  Stream<List<Map>> getAds() {
    // print("TUWEKU AREMIX:: $uID");
    var ref = FirebaseFirestore.instance.collection('ads').where("status", isEqualTo: "Pending");

    return ref.snapshots().map((list) {
      return list.docs.map((e) {
        print("ADSLIST:: ${e.data()}");
        return e.data();
      }).toList();
    });
  }

  @override
  void onInit() async {
    super.onInit();
    getAds();
  }

  var selectedIndex = 0.obs;

  void setAccessToken(String token) {
    accessToken = token;
  }

  dynamic get tabController => _tabController;

  void jumpTo(int pos) {
    tabController.jumpToTab(pos);
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
