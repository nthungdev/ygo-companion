/// Convert a [Duration] to 00:00 format String
/// Ex: 14:49 as 14 minutes and 49 seconds
String durationToDigital(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;

  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}
