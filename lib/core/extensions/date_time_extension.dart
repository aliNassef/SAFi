extension DateTimeExtension on DateTime {
  /// Format as yyyy-MM-dd
  String get toShortDate =>
      "${year.toString().padLeft(4, '0')}-"
      "${month.toString().padLeft(2, '0')}-"
      "${day.toString().padLeft(2, '0')}";

  /// Format as dd/MM/yyyy
  String get toDDMMYYYY =>
      "${day.toString().padLeft(2, '0')}/"
      "${month.toString().padLeft(2, '0')}/"
      '${year.toString()}';

  /// Check if the date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Return a copy without time part (hour, minute, second)
  DateTime get onlyDate => DateTime(year, month, day);

  /// Number of days from another date
  int daysFrom(DateTime other) => difference(other).inDays.abs();

  /// Add days
  DateTime addDays(int days) => add(Duration(days: days));

  /// Subtract days
  DateTime subtractDays(int days) => subtract(Duration(days: days));
}
