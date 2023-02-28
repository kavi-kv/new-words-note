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

//?:-> Light Theme
  static ThemeData get darkTheme {
  return ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black87,
    colorScheme: ColorScheme.dark(
      secondary: Colors.blue.shade400,
    ),
    appBarTheme:  AppBarTheme(
      color: Colors.brown[400]
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black),
      displayMedium: TextStyle(color: Colors.black),
      displaySmall: TextStyle(color: Colors.black),
    ), 
  );
}

  //?:-> Dark Theme
  static ThemeData get lightTheme {
  return ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    colorScheme:  ColorScheme.light(
      secondary: Colors.orange.shade300,
    ),
    appBarTheme:  AppBarTheme(
      color: Colors.blue[200]
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
    ), 
  );
}

}