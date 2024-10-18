import 'package:flutter/material.dart';

import 'dart:ui';

const redColor = Color(0xFFDA0000);
const blackColor = Color(0xFF000000);
const buttonColor = Color(0xFF49108C);
const secondaryColor =  Color(0xffCFCFCF);
const greyColor =  Color(0xffD9D9D9);
const background =  Color(0xffF6F6F6);

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.white,
  fontFamily: 'Inter',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.green)
      .copyWith(background: Colors.white),
);
