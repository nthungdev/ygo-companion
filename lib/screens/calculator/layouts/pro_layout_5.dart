import 'package:flutter/material.dart';

import 'package:ygo_companion/models/player.dart';
import 'package:ygo_companion/screens/calculator/widgets/calculator_pad_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/duel_log_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/icon_buttons_row_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/main_clock_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_lp_5.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_clock_5.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/widgets/coin_result.dart';
import 'package:ygo_companion/widgets/dice_result.dart';

class ProLayout5 extends StatelessWidget {
  final Duration mainClockDuration;
  final Duration clockADuration;
  final Duration clockBDuration;
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
  final VoidCallback? onPlayerALPTap;
  final VoidCallback? onPlayerBLPTap;
  final VoidCallback onMainClockTap;
  final VoidCallback onMainClockLongPressed;
  final VoidCallback onPlayerAClockTap;
  final VoidCallback onPlayerBClockTap;
  final VoidCallback onPlayerAClockLongPressed;
  final VoidCallback onPlayerBClockLongPressed;
  final VoidCallback onCoin;
  final VoidCallback onDice;
  final VoidCallback onReset;
  final VoidCallback onPlayPause;

  const ProLayout5({
    super.key,
    this.isPlaying = false,
    this.isUsingCoin = false,
    this.isUsingDice = false,
    required this.onPlayerFocused,
    required this.mainClockDuration,
    required this.clockADuration,
    required this.clockBDuration,
    required this.onPlayerAClockTap,
    required this.onPlayerBClockTap,
    this.onPlayerALPTap,
    this.onPlayerBLPTap,
    required this.onPlayerALongPress,
    required this.onPlayerBLongPress,
    required this.playerA,
    required this.playerB,
    required this.onPlayerAClockLongPressed,
    required this.onPlayerBClockLongPressed,
    required this.onInputTap,
    required this.onMainClockTap,
    required this.onPlayerATap,
    required this.onPlayerBTap,
    required this.playerASelected,
    required this.onCoin,
    required this.onDice,
    required this.onReset,
    required this.onPlayPause,
    required this.onCloseCoin,
    required this.onCloseDice,
    required this.onMainClockLongPressed,
  });

  static const double space = 5.0;
  static const double layoutAspectRatio = 16 / 9;
  static const double iconBoxHeight = 50.0;
  static final boxBackgroundColor = Colors.white.withAlpha(200);
  static final selectedColor = Colors.amber.withAlpha(200);

  Widget _buildButtonsAndCalculator({
    required double iconBoxWidth,
    required double height,
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
              // color: boxBackgroundColor,
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
            : const BoxDecoration(
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
                  aspectRatio: layoutAspectRatio,
                  child: LayoutBuilder(
                    builder: (context, viewConstraint) {
                      final topRowHeight = viewConstraint.maxHeight / 5;

                      return Column(
                        children: <Widget>[
                          Container(
                            height: topRowHeight,
                            margin: const EdgeInsets.only(
                                top: space, left: space, right: space),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: PlayerLP(
                                    label: "Player A LP",
                                    lp: playerA.lp,
                                    // calculation: playerA.calculation,
                                    onPressed: onPlayerATap,
                                    onLongPress: onPlayerALongPress,
                                    selected: playerASelected,
                                  ),
                                ),
                                const SizedBox(width: space),
                                Expanded(
                                  flex: 1,
                                  child: PlayerClock(
                                    label: "Player A Clock",
                                    // clock: clockADuration,
                                    // color: boxBackgroundColor,
                                    onTap: onPlayerAClockTap,
                                    onLongPressed: onPlayerAClockLongPressed,
                                    forPlayerA: true,
                                  ),
                                ),
                                const SizedBox(width: space),
                                Expanded(
                                  flex: 2,
                                  child: MainClock(
                                    clock: mainClockDuration,
                                    onTap: onMainClockTap,
                                    // color: boxBackgroundColor,
                                  ),
                                ),
                                const SizedBox(width: space),
                                Expanded(
                                  flex: 1,
                                  child: PlayerClock(
                                    label: "Player B Clock",
                                    // clock: clockBDuration,
                                    // color: boxBackgroundColor,
                                    onTap: onPlayerBClockTap,
                                    onLongPressed: onPlayerBClockLongPressed,
                                    forPlayerA: false,
                                  ),
                                ),
                                const SizedBox(width: space),
                                Expanded(
                                  flex: 1,
                                  child: PlayerLP(
                                    label: "Player B LP",
                                    lp: playerB.lp,
                                    selected: !playerASelected,
                                    onLongPress: onPlayerBLongPress,
                                    // calculation: playerB.calculation,
                                    onPressed: onPlayerBTap,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                                builder: (context, boxConstraint) {
                              final bottomRowHeight = boxConstraint.maxHeight;
                              final calculatorPadHeight =
                                  bottomRowHeight - iconBoxHeight - space * 3;
                              final iconBoxWidth =
                                  (calculatorPadHeight / 4) * 5 + space;

                              return Row(
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
                                    height: boxConstraint.maxHeight * 0.2,
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
            if (isUsingCoin) CoinResult(onClose: onCloseCoin),
            if (isUsingDice) DiceResult(onClose: onCloseDice),
          ],
        ),
      ),
    );
  }
}
