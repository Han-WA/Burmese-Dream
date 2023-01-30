import 'package:flutter/material.dart';
import 'app_color.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: firstColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondColor),
  splashColor: firstColor,
  highlightColor: secondColor,
  fontFamily: "Poppins",
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
    ),
  ),
);
