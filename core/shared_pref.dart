import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/push_notification/push_notification.dart';

class SharedPref {
  SharedPreferences? sharedPref;

  Future<SharedPreferences> get _instance async => sharedPref ??= await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    sharedPref = await _instance;
    return sharedPref!;
  }

  Future<bool> save({required String key, required dynamic value}) async {
    if (sharedPref == null) await init();
    switch (value.runtimeType) {
      case const (String):
        return await sharedPref!.setString(key, value);
      case const (bool):
        return await sharedPref!.setBool(key, value);
      case const (int):
        return await sharedPref!.setInt(key, value);
      case const (double):
        return await sharedPref!.setDouble(key, value);
      default:
        return await sharedPref!.setString(key, jsonEncode(value));
    }
  }

  Future<String?> getUserToken() async {
    if (sharedPref == null) await init();
    userToken = sharedPref?.getString("token");
    return userToken;
  }

  logout() async {
    if (sharedPref == null) await init();
    sharedPref!.clear();
    notificationCounterValueNotifer = ValueNotifier(0);
    // Screen.openAsNewPage(const LoginScreen());
  }
}
