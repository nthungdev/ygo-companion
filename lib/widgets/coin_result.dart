import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ygo_companion/states/coin_state.dart';
import 'package:ygo_companion/states/theme_state.dart';

class CoinResult extends StatefulWidget {
  CoinResult({
    Key key,
    this.value,
    this.onClose,
  }) : super(key: key);

  final int value;
  final VoidCallback onClose;

  @override
  _CoinResultState createState() => _CoinResultState();
}

class _CoinResultState extends State<CoinResult> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black.withAlpha(200),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.shortestSide * 0.5,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ThemeState.of(context).isDarkMode ? Colors.grey : Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Selector<CoinState, bool>(
              selector: (_, state) => state.coinResult,
              builder: (_, coinResult, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide * 0.02),
                      child: Image.asset(
                        coinResult
                            ? "assets/images/calculator/coin_head.png"
                            : "assets/images/calculator/coin_tail.png",
                        width: MediaQuery.of(context).size.shortestSide * 0.45,
                        height: MediaQuery.of(context).size.shortestSide * 0.45,
                      ),
                    ),
                    Text(coinResult ? "Head" : "Tail"),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
