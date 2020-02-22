import 'package:flutter/material.dart';
import 'package:ygo_companion/screens/calculator/widgets/icon_button_pl2.dart';
import 'package:ygo_companion/size_config.dart';
import 'package:ygo_companion/util/formatter.dart' as Formatter;

/// Main timer for Pro Layout 2
class MainTimerPL2 extends StatelessWidget {
  final Function onCoinTapped;
  final Function onDieTapped;
  final Function onRestoreLP;
  final Function onResetTimer;
  final Color boxColor;

  const MainTimerPL2({
    Key key,
    @required this.boxColor,
    this.onCoinTapped,
    this.onDieTapped,
    this.onResetTimer,
    this.onRestoreLP,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: boxColor,
      child: Column(
        children: <Widget>[
          Text(
            Formatter.durationToDigital(Duration(seconds: 0)),
            style: TextStyle(fontSize: SizeConfig.getSafeBlockVertical(9)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButtonPL2(
                icon: Icon(Icons.restore),
                onPressed: () => {},
              ),
              IconButtonPL2(
                icon: Image(
                  image: AssetImage("assets/images/calculator/coin_head.png"),
                  height: 24,
                ),
                onPressed: () => {},
              ),
              IconButtonPL2(
                icon: Image(
                  image: AssetImage("assets/images/calculator/dice_6.png"),
                  height: 24,
                ),
                onPressed: () => {},
              ),
              IconButtonPL2(
                icon: Icon(Icons.refresh),
                onPressed: () => {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
