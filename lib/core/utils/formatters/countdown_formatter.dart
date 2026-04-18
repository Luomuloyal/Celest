class CountdownFormatter {
  const CountdownFormatter._();

  static CountdownParts toParts(Duration duration) {
    final safeDuration = duration.isNegative ? Duration.zero : duration;
    final days = safeDuration.inDays;
    final hours = safeDuration.inHours.remainder(24);
    final minutes = safeDuration.inMinutes.remainder(60);
    final seconds = safeDuration.inSeconds.remainder(60);

    return CountdownParts(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  static String twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  static String formatDigital(Duration duration) {
    final parts = toParts(duration);
    if (parts.days > 0) {
      return '${parts.days}d ${twoDigits(parts.hours)}:${twoDigits(parts.minutes)}';
    }

    return '${twoDigits(parts.hours)}:${twoDigits(parts.minutes)}:${twoDigits(parts.seconds)}';
  }
}

class CountdownParts {
  const CountdownParts({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
}
