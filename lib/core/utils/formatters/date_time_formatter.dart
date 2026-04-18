class DateTimeFormatter {
  const DateTimeFormatter._();

  static String formatYmd(DateTime value) {
    return '${value.year}-${_twoDigits(value.month)}-${_twoDigits(value.day)}';
  }

  static String formatMdHm(DateTime value) {
    return '${value.month}月${value.day}日 ${_twoDigits(value.hour)}:${_twoDigits(value.minute)}';
  }

  static String formatYmdHm(DateTime value) {
    return '${formatYmd(value)} ${_twoDigits(value.hour)}:${_twoDigits(value.minute)}';
  }

  static String formatRange({
    required DateTime start,
    DateTime? end,
  }) {
    final startText = '${start.year}-${_twoDigits(start.month)}';
    if (end == null) {
      return '$startText 至今';
    }

    return '$startText 至 ${end.year}-${_twoDigits(end.month)}';
  }

  static String formatRelative(
    DateTime value, {
    DateTime? now,
  }) {
    final current = now ?? DateTime.now();
    final difference = current.difference(value);

    if (difference.inMinutes < 1) {
      return '刚刚';
    }

    if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    }

    if (_isSameDay(value, current)) {
      return '${difference.inHours}小时前';
    }

    final yesterday = current.subtract(const Duration(days: 1));
    if (_isSameDay(value, yesterday)) {
      return '昨天 ${_twoDigits(value.hour)}:${_twoDigits(value.minute)}';
    }

    if (value.year == current.year) {
      return formatMdHm(value);
    }

    return formatYmdHm(value);
  }

  static String _twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  static bool _isSameDay(DateTime left, DateTime right) {
    return left.year == right.year &&
        left.month == right.month &&
        left.day == right.day;
  }
}
