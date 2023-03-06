import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkMode = false;
  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme()
  {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

//?xz:-> dark Theme
  static ThemeData get darkTheme {
  return ThemeData(
    primaryColor: Colors.green[400],
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff181823),
    colorScheme: ColorScheme.dark(
      secondary: Colors.blue.shade400,
    ),
    appBarTheme: const  AppBarTheme(
      color: Color(0xff060020)
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
    ), 
  );

}

  //?:-> light Theme
  static ThemeData get lightTheme {
  return ThemeData(
    primaryColor: Colors.red[400],
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme:  ColorScheme.light(
      secondary: Colors.blue.shade400,
    ),
    appBarTheme: const  AppBarTheme(
      color: Color(0xffF0EEED)
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ), 
  );
}

}