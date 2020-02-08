import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Perform calculator logic and control the state of Calculator Screen
class CalculatorState extends ChangeNotifier {
  static CalculatorState of(BuildContext context, {bool listen: true}) {
    return Provider.of<CalculatorState>(context, listen: listen);
  }

  // PRIVATE VARIABLES //

  // GETTERS //

  // METHODS //

}
