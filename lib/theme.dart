import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This class overrides the default theme of Flutter
class CompanionTheme {
  static ThemeData of(BuildContext context) {
    return Theme.of(context).copyWith();
  }
}
