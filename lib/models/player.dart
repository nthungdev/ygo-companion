class Player {
  static const startingLp = 8000;

  String name;

  /// Life points
  int lp;

  /// Temporary calculation
  String calculation;

  /// Watch
  Duration watch;

  List<String> logs;

  Player({
    this.name,
    this.lp = startingLp,
    this.calculation = "",
    this.watch = Duration.zero,
    this.logs,
  }) {
    logs = [startingLp.toString()];
  }

  Player copyWith({
    String name,
    int lp,
    String calculation,
    Duration duration,
    List<String> logs,
  }) {
    return Player(
      name: name ?? this.name,
      lp: lp ?? this.lp,
      calculation: calculation ?? this.calculation,
      watch: watch ?? this.watch,
      logs: logs ?? this.logs,
    );
  }

  resetLp() {
    lp = startingLp;
  }

  clearLogs() {
    logs = [startingLp.toString()];
  }
}
