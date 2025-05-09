import 'package:flutter/material.dart';
import 'package:campus_connects/constants/theme/theme_shared.dart';

class ThemeProvider extends ChangeNotifier{

  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  // ThemeData _themeData = lightMode;
  //
  // ThemeData get themeData => _themeData;
  //
  // setThemeData(ThemeData themeData){
  //   _themeData = themeData;
  //   notifyListeners();
  // }
  //
  // void toggleTheme(){
  //   if(_themeData == lightMode){
  //     _themeData = darkMode;
  //   }else{
  //     _themeData = lightMode;
  //   }
  // }

}