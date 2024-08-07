import 'package:flutter/material.dart';

import '../../core/constants.dart';
import 'colors.dart';

ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    tabBarTheme: const TabBarTheme(
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
      indicatorColor: primaryClr,
    ),
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        titleTextStyle: TextStyle(
            fontSize: 16, fontFamily: inter500, color: appBarTitleClr),
        shape: Border(bottom: BorderSide(color: inputBorderClr))),
    fontFamily: inter400);
