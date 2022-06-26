import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:niger_delta_unity_app/model/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  final BuildContext? context;
  static var prefs;

  PreferenceManager(this.context) {
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveAccessToken(String token) {
    prefs.setString('accessToken', token);
  }

  void setRememberMe(String email, String password, bool value) {
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('remember', value);
  }

  String getEmail() =>
      prefs != null ? prefs!.getString('email') : '';

  String getPassword() =>
      prefs != null ? prefs!.getString('password') : '';

  bool shouldRemember() => prefs!.getBool('remember') ?? false;

  void setIsLoggedIn(bool loggenIn) {
    prefs.setBool('loggedIn', loggenIn);
  }

  bool getIsLoggedIn() => prefs!.getBool('loggedIn') ?? false;

  String getAccessToken() =>
      prefs != null ? prefs!.getString('accessToken') : '';

  void setUserData(String rawJson) {
    prefs!.setString('user', rawJson);
  }

  UserModel getUser() {
    final rawJson = prefs.getString('user') ?? '{}';
    Map<String, dynamic> map = jsonDecode(rawJson);
    return UserModel.fromJson(map);
  }

  void clearProfile() {
    prefs!.remove("accessToken");
    prefs!.remove("loggedIn");
    prefs!.remove("user");
  }
}
