import 'package:flutter/material.dart';

class CompanionTheme {
  static Color primaryColor = Colors.deepPurple;
  static Color accentColor = Colors.amber.withAlpha(200);

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      accentColor: accentColor,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          // brightness: Brightness.dark,
        ),
        // textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      accentColor: accentColor,
      // backgroundColor: Colors.grey[800],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple,
        textTheme: ButtonTextTheme.normal,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      buttonColor: primaryColor,
      primaryColorDark: primaryColor,
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: primaryColor,
        fillColor: primaryColor,
        selectedColor: primaryColor,
      ),
    );
  }
}
