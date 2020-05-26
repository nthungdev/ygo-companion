import 'package:flutter/material.dart';
import 'package:ygo_companion/models/player.dart';
import 'package:ygo_companion/screens/calculator/widgets/calculator_pad_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/duel_log_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/main_watch_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_lp_4.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_watch_4.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/widgets/coin_result.dart';
import 'package:ygo_companion/widgets/dice_result.dart';
import 'package:ygo_companion/widgets/icons/custom_icons.dart';

class ProLayout5 extends StatelessWidget {
  final Duration mainWatchDuration;
  final Duration watchADuration;
  final Duration watchBDuration;
  final Player playerA;
  final Player playerB;
  final bool isPlaying;
  final bool isUsingCoin;
  final bool isUsingDice;
  final bool playerASelected;
  final void Function(String) onInputTap;
  final void Function(bool forPlayerA) onPlayerFocused;
  final VoidCallback onCloseCoin;
  final VoidCallback onCloseDice;
  final VoidCallback onPlayerATap;
  final VoidCallback onPlayerBTap;
  final VoidCallback onPlayerALongPress;
  final VoidCallback onPlayerBLongPress;
  final VoidCallback onPlayerALPTap;
  final VoidCallback onPlayerBLPTap;
  final VoidCallback onMainWatchTap;
  final VoidCallback onPlayerAWatchTap;
  final VoidCallback onPlayerBWatchTap;
  final VoidCallback onPlayerAWatchLongPressed;
  final VoidCallback onPlayerBWatchLongPressed;
  final VoidCallback onCoin;
  final VoidCallback onDice;
  final VoidCallback onReset;
  final VoidCallback onPlayPause;

  const ProLayout5({
    Key key,
    this.onPlayerFocused,
    this.mainWatchDuration,
    this.watchADuration,
    this.watchBDuration,
    this.onPlayerAWatchTap,
    this.onPlayerBWatchTap,
    this.onPlayerALPTap,
    this.onPlayerBLPTap,
    this.onPlayerALongPress,
    this.onPlayerBLongPress,
    this.playerA,
    this.playerB,
    this.onPlayerAWatchLongPressed,
    this.onPlayerBWatchLongPressed,
    this.onInputTap,
    this.onMainWatchTap,
    this.onPlayerATap,
    this.onPlayerBTap,
    this.playerASelected,
    this.onCoin,
    this.onDice,
    this.onReset,
    this.onPlayPause,
    this.isPlaying = false,
    this.isUsingCoin = false,
    this.isUsingDice = false,
    this.onCloseCoin,
    this.onCloseDice,
  })  : assert(playerA != null),
        assert(playerB != null),
        super(key: key);

  static const double space = 5.0;
  static const double viewAspectRatio = 16 / 9;
  static const double iconBoxHeight = 50.0;
  static final boxBackgroundColor = Colors.white.withAlpha(200);
  static final selectedColor = Colors.amber.withAlpha(200);

  Widget _buildButtonsAndCalculator({
    double iconBoxWidth,
    double height,
  }) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: space),
          child: IconButtonsRow(
            height: iconBoxHeight,
            width: iconBoxWidth,
            color: boxBackgroundColor,
            onCoin: onCoin,
            onDice: onDice,
            onReset: onReset,
            isPlaying: isPlaying,
            onPlayPause: onPlayPause,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: space),
            child: CalculatorPad(
              onKeyPress: onInputTap,
              color: boxBackgroundColor,
              space: space,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ThemeState.of(context, listen: false).isDarkMode
            ? null
            : BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/calculator/background.png"),
                ),
              ),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Center(
                child: AspectRatio(
                  aspectRatio: viewAspectRatio,
                  child: Container(
                    child: LayoutBuilder(
                      builder: (context, viewConstraint) {
                        final topRowHeight = viewConstraint.maxHeight / 5;

                        return Column(
                          children: <Widget>[
                            Container(
                              height: topRowHeight,
                              margin: const EdgeInsets.only(top: space, left: space, right: space),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: PlayerLP(
                                      label: "Player A LP",
                                      lp: playerA.lp,
                                      calculation: playerA.calculation,
                                      onPressed: onPlayerATap,
                                      onLongPress: onPlayerALongPress,
                                      selected: playerASelected,
                                    ),
                                  ),
                                  SizedBox(width: space),
                                  Expanded(
                                    flex: 1,
                                    child: PlayerWatch(
                                      label: "Player A Watch",
                                      watch: watchADuration,
                                      color: boxBackgroundColor,
                                      onTap: onPlayerAWatchTap,
                                      onLongPressed: onPlayerAWatchLongPressed,
                                      forPlayerA: true,
                                    ),
                                  ),
                                  SizedBox(width: space),
                                  Expanded(
                                    flex: 2,
                                    child: MainWatch(
                                      watch: mainWatchDuration,
                                      onTap: onMainWatchTap,
                                      color: boxBackgroundColor,
                                    ),
                                  ),
                                  SizedBox(width: space),
                                  Expanded(
                                    flex: 1,
                                    child: PlayerWatch(
                                      label: "Player B Watch",
                                      watch: watchBDuration,
                                      color: boxBackgroundColor,
                                      onTap: onPlayerBWatchTap,
                                      onLongPressed: onPlayerBWatchLongPressed,
                                      forPlayerA: false,
                                    ),
                                  ),
                                  SizedBox(width: space),
                                  Expanded(
                                    flex: 1,
                                    child: PlayerLP(
                                      label: "Player B LP",
                                      lp: playerB.lp,
                                      selected: !playerASelected,
                                      onLongPress: onPlayerBLongPress,
                                      calculation: playerB.calculation,
                                      onPressed: onPlayerBTap,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: LayoutBuilder(builder: (context, bottomConstraint) {
                                final bottomRowHeight = bottomConstraint.maxHeight;
                                final calculatorPadHeight =
                                    bottomRowHeight - iconBoxHeight - space * 3;
                                final iconBoxWidth = (calculatorPadHeight / 4) * 5 + space;

                                return Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(space),
                                          child: DuelLog(
                                            logs: playerA.logs,
                                            calculation: playerA.calculation,
                                            selected: playerASelected,
                                          ),
                                        ),
                                      ),
                                      _buildButtonsAndCalculator(
                                        iconBoxWidth: iconBoxWidth,
                                        height: bottomConstraint.maxHeight * 0.2,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(space),
                                          child: DuelLog(
                                            logs: playerB.logs,
                                            calculation: playerB.calculation,
                                            selected: !playerASelected,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (isUsingCoin) CoinResult(onClose: onCloseCoin),
            if (isUsingDice) DiceResult(onClose: onCloseDice),
          ],
        ),
      ),
    );
  }
}

class IconButtonsRow extends StatelessWidget {
  const IconButtonsRow({
    Key key,
    @required this.color,
    @required this.height,
    @required this.width,
    this.onCoin,
    this.onDice,
    this.onReset,
    this.onPlayPause,
    this.isPlaying = false,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final VoidCallback onCoin;
  final VoidCallback onDice;
  final VoidCallback onReset;
  final VoidCallback onPlayPause;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Theme.of(context).backgroundColor.withAlpha(200),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: onReset,
              icon: Icon(Icons.history),
              tooltip: "Reset clocks",
            ),
            IconButton(
              onPressed: onPlayPause,
              icon: isPlaying ? Icon(Icons.pause_circle_filled) : Icon(Icons.play_circle_filled),
              tooltip: isPlaying ? "Pause all clocks" : "Start all clocks",
            ),
            IconButton(
              onPressed: onCoin,
              icon: Icon(CustomIcons.coin_circle),
              tooltip: "Toss a coin",
            ),
            IconButton(
              onPressed: onDice,
              icon: Icon(CustomIcons.dice),
              tooltip: "Roll a dice",
            ),
          ],
        ),
      ),
    );
  }
}
