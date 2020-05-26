import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ygo_companion/screens/calculator/layouts/pro_layout_5.dart';
import 'package:ygo_companion/states/calculator_setting_state.dart';
import 'package:ygo_companion/states/calculator_state.dart';
import 'package:ygo_companion/states/coin_state.dart';
import 'package:ygo_companion/states/dice_state.dart';
import 'package:ygo_companion/states/watch_state.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  /// [false] if playerB is selected
  bool _playerASelected = true;
  bool _isPlaying = false;
  bool _isUsingDice = false;
  bool _isUsingCoin = false;
  WatchState _staticWatchState;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // SystemChrome.setEnabledSystemUIOverlays([]);
    _staticWatchState = WatchState.of(context, listen: false);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _staticWatchState.stopAll(notifyListeners: false);
    super.dispose();
  }

  void handleWatchTap({
    bool forMainWatch = false,
    bool forPlayerA = false,
    bool forPlayerB = false,
  }) {
    if (forMainWatch)
      _staticWatchState.isRunning
          ? _staticWatchState.stop(mainWatch: true)
          : _staticWatchState.start(mainWatch: true);
    else if (forPlayerA) {
      _staticWatchState.isRunningA
          ? _staticWatchState.stop(watchA: true)
          : _staticWatchState.start(watchA: true);
    } else if (forPlayerB) {
      _staticWatchState.isRunningB
          ? _staticWatchState.stop(watchB: true)
          : _staticWatchState.start(watchB: true);
    }
  }

  void handleMainWatchTap() {
    print('handleMainWatchTap timerService running? ${_staticWatchState.isRunning}');

    if (_staticWatchState.isRunning) {
      _staticWatchState.stop(mainWatch: true);
    } else {
      _staticWatchState.start(mainWatch: true);
    }
  }

  void handleCalculatorInput(String input) {
    final calculatorState = CalculatorState.of(context, listen: false);
    try {
      calculatorState.playerInput(_playerASelected, input);
    } catch (error) {
      showToast(
        'Invalid expression',
        context: context,
        backgroundColor: Colors.red,
        borderRadius: BorderRadius.circular(30),
      );
    }
  }

  void handlePlayerFocused(bool forPlayerA) {
    setState(() {
      _playerASelected = forPlayerA;
    });
  }

  void handlePlayerLpLongPressed(bool forPlayerA) {
    final calculatorState = CalculatorState.of(context, listen: false);
    calculatorState.resetPlayerLP(forPlayerA);
  }

  void handlePlayerWatchTap(bool forPlayerA) {
    // TODO: refactor
    print('handlePlayerWatchTap forPlayerA $forPlayerA');

    if (forPlayerA) {
      _staticWatchState.isRunningA
          ? _staticWatchState.stop(watchA: true)
          : _staticWatchState.start(watchA: true);
    } else {
      _staticWatchState.isRunningB
          ? _staticWatchState.stop(watchB: true)
          : _staticWatchState.start(watchB: true);
    }
  }

  void handlePlayerWatchLongPressed(bool forPlayerA) {
    print('handlePlayerWatchLongPressed forPlayerA $forPlayerA');
    _staticWatchState.reset(
      watchA: forPlayerA,
      watchB: !forPlayerA,
    );
  }

  void _handlePlayPauseTap() {
    if (_isPlaying) {
      _staticWatchState.stop(watchA: true, watchB: true, mainWatch: true);
    } else {
      _staticWatchState.start(watchA: true, watchB: true, mainWatch: true);
    }

    setState(() => _isPlaying = !_isPlaying);
  }

  void _handleResetTap() {
    _staticWatchState.stop(watchA: true, watchB: true, mainWatch: true);
    _staticWatchState.resetAll();
    setState(() => _isPlaying = false);
  }

  void _handleRollDice() async {
    setState(() => _isUsingDice = true);
    DiceState.of(context, listen: false).rollDice();
  }

  void _handleFlipCoin() async {
    setState(() => _isUsingCoin = true);
    CoinState.of(context, listen: false).flipCoin();
  }

  @override
  Widget build(BuildContext context) {
    final timerService = WatchState.of(context);
    final calculatorState = CalculatorState.of(context);
    final calculatorSettingState = CalculatorSettingState.of(context);

    switch (calculatorSettingState.calculatorLayout) {
      case CalculatorLayout.HN_AV_1:
      case CalculatorLayout.AT_AV_1:
      default:
        return ProLayout5(
          isPlaying: _isPlaying,
          mainWatchDuration: timerService.currentDuration,
          watchADuration: timerService.currentDurationA,
          watchBDuration: timerService.currentDurationB,
          playerA: calculatorState.playerA,
          playerB: calculatorState.playerB,
          playerASelected: _playerASelected,
          onInputTap: handleCalculatorInput,
          onPlayerFocused: handlePlayerFocused,
          onPlayerATap: () => handlePlayerFocused(true),
          onPlayerBTap: () => handlePlayerFocused(false),
          onPlayerALongPress: () => handlePlayerLpLongPressed(true),
          onPlayerBLongPress: () => handlePlayerLpLongPressed(false),
          onMainWatchTap: () => handleWatchTap(forMainWatch: true),
          onPlayerAWatchTap: () => handleWatchTap(forPlayerA: true),
          onPlayerBWatchTap: () => handleWatchTap(forPlayerB: true),
          onPlayerAWatchLongPressed: () => handlePlayerWatchLongPressed(true),
          onPlayerBWatchLongPressed: () => handlePlayerWatchLongPressed(false),
          onPlayPause: _handlePlayPauseTap,
          onReset: _handleResetTap,
          onDice: _handleRollDice,
          onCoin: _handleFlipCoin,
          onCloseCoin: () => setState(() => _isUsingCoin = false),
          onCloseDice: () => setState(() => _isUsingDice = false),
          isUsingCoin: _isUsingCoin,
          isUsingDice: _isUsingDice,
        );
    }
  }
}
