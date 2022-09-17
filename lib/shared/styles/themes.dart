import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/shared/styles/colors.dart';


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("333739"),
  primarySwatch: defaultcolor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: HexColor("333739"),
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor("333739"),
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor("333739"),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  ),
);
ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
  primarySwatch: defaultcolor,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultcolor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
);
