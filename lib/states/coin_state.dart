import 'dart:math';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:provider/provider.dart';

class CoinState extends ChangeNotifier {
  static CoinState of(BuildContext context, {bool listen = true}) {
    return Provider.of<CoinState>(context, listen: listen);
  }

  final _randomizer = Random();
  bool? _coinResult;

  bool get coinResult => _coinResult ?? true;

  // METHODS //

  void flipCoin() async {
    _coinResult = _randomizer.nextBool();

    for (int roll = 0; roll < 10; roll++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _coinResult = !_coinResult!;
      notifyListeners();
    }
  }
}
