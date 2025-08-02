import 'package:flutter/material.dart';

class CompanionTheme {
  static Color primaryColor = Colors.deepPurple;
  static Color secondaryColor = Colors.amber.withAlpha(200);

  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        surface: Colors.white,
        secondary: secondaryColor,
      ),
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
      colorScheme: ColorScheme.dark(
        // background: Colors.grey[800],
        secondary: secondaryColor,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.deepPurple,
        textTheme: ButtonTextTheme.normal,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      primaryColorDark: primaryColor,
      // TODO update button theme
      // buttonColor: primaryColor,
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: primaryColor,
        fillColor: primaryColor,
        selectedColor: primaryColor,
      ),
    );
  }
}
