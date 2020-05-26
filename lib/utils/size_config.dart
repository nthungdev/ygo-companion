/// Original: https://github.com/dancamdev/effectively_scale_UI_according_to_different_screen_sizes

import 'package:flutter/widgets.dart';

/// Need to call [init] method before using this class.
/// Recommend calling [init] in the build method
class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  /// 1% of usable screen width
  static double blockSizeHorizontal;

  /// 1% of usable screen Heigth
  static double blockSizeVertical;

  /// Multiply 1% of usable screen width by [size]
  static double getBlockSizeHorizontal(num size) => blockSizeHorizontal * size;

  /// Multiply 1% of usable screen height by [size]
  static double getBlockSizeVertical(num size) => blockSizeVertical * size;

  /// 1% of usable screen width within the Safe Area
  static double safeBlockHorizontal;

  /// 1% of usable screen height within the Safe Area
  static double safeBlockVertical;

  /// Multiply 1% of usable screen width within the Safe Area by [size]
  static double getSafeBlockHorizontal(num size) => safeBlockHorizontal * size;

  /// Multiply 1% of usable screen height within the Safe Area by [size]
  static double getSafeBlockVertical(num size) => safeBlockVertical * size;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    final _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    final _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
