import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class WatchState extends ChangeNotifier {
  static WatchState of(BuildContext context, {bool listen = true}) {
    return Provider.of<WatchState>(context, listen: listen);
  }

  static const Duration _tickFrequency = const Duration(milliseconds: 200);

  Timer _timer;
  Stopwatch _watch;
  Stopwatch _watchA;
  Stopwatch _watchB;

  Duration get currentDuration => _watch.elapsed;
  Duration get currentDurationA => _watchA.elapsed;
  Duration get currentDurationB => _watchB.elapsed;

  bool get isRunning => _watch.isRunning;
  bool get isRunningA => _watchA.isRunning;
  bool get isRunningB => _watchB.isRunning;

  WatchState() {
    _watch = Stopwatch();
    _watchA = Stopwatch();
    _watchB = Stopwatch();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _watch.stop();
    _watchA.stop();
    _watchB.stop();
    super.dispose();
  }

  void _onTick(Timer timer) {
    print("tick ${timer.tick}");
    notifyListeners();
  }

  void start({
    bool mainWatch = false,
    bool watchA = false,
    bool watchB = false,
  }) {
    if (_timer == null) {
      _timer = Timer.periodic(_tickFrequency, _onTick);
    }

    if (mainWatch) _watch.start();
    if (watchA) _watchA.start();
    if (watchB) _watchB.start();

    notifyListeners();
  }

  void stopAll({bool notifyListeners = true}) {
    stop(
      mainWatch: true,
      watchA: true,
      watchB: true,
      notifyListeners: notifyListeners,
    );
  }

  void stop({
    bool mainWatch = false,
    bool watchA = false,
    bool watchB = false,
    bool notifyListeners = true,
  }) {
    if (mainWatch) _watch.stop();
    if (watchA) _watchA.stop();
    if (watchB) _watchB.stop();

    if (!_watch.isRunning && !_watchA.isRunning && !_watchB.isRunning) {
      _timer?.cancel();
      _timer = null;
    }

    print('notifyListeners $notifyListeners');
    if (notifyListeners) this.notifyListeners();
  }

  /// Set all watches to 0
  void resetAll() => reset(watchA: true, watchB: true, mainWatch: true);

  /// Set selected watches to 0
  void reset({
    bool mainWatch = false,
    bool watchA = false,
    bool watchB = false,
  }) {
    // stop();
    // _watch.reset();
    // _currentDuration = Duration.zero;
    if (mainWatch) _watch.reset();
    if (watchA) _watchA.reset();
    if (watchB) _watchB.reset();

    notifyListeners();
  }
}
