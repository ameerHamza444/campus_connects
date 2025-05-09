import 'package:flutter/material.dart';
import 'package:campus_connects/constants/app_export.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorUtils().seedColor,
    primary: ColorUtils().primaryColor,
    secondary: ColorUtils().secondaryColor,
    surface: ColorUtils().screenBackgroundColor,
  ),
  iconTheme: IconThemeData(
    color: ColorUtils().blackColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    bodySmall: TextStyle(
      fontFamily: "Poppins",
    ),
    displayLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    displayMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    displaySmall: TextStyle(
      fontFamily: "Poppins",
    ),
    headlineLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    headlineMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    headlineSmall: TextStyle(
      fontFamily: "Poppins",
    ),
    labelLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    labelMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    labelSmall: TextStyle(
      fontFamily: "Poppins",
    ),
    titleMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    titleSmall: TextStyle(
      fontFamily: "Poppins",
    ),
    titleLarge: TextStyle(
      fontFamily: "Poppins",
    ),
  ),
  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorUtils().seedColor,
    primary: ColorUtils().primaryColor,
    secondary: ColorUtils().secondaryColor,
    surface: ColorUtils().screenBackgroundColor,
  ),
  iconTheme: IconThemeData(
    color: ColorUtils().blackColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    bodySmall: TextStyle(
      fontFamily: "Poppins",
    ),
    displayLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    displayMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    displaySmall: TextStyle(
      fontFamily: "Poppins",
    ),
    headlineLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    headlineMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    headlineSmall: TextStyle(
      fontFamily: "Poppins",
    ),
    labelLarge: TextStyle(
      fontFamily: "Poppins",
    ),
    labelMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    labelSmall: TextStyle(
      fontFamily: "Poppins",
    ),
    titleMedium: TextStyle(
      fontFamily: "Poppins",
    ),
    titleSmall: TextStyle(
      fontFamily: "Poppins",
    ),
    titleLarge: TextStyle(
      fontFamily: "Poppins",
    ),
  ),
  useMaterial3: true,
);

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme ? darkMode : lightMode;
  }
}
