enum TimeFilterType {
  lastSession,
  lastWeek,
  adjusted,
}

/// the initial dates (start and end) of [TimeFilterType.adjusted]
/// are the same as [TimeFilterType.lastWeek]
extension TimeFilterExtension on TimeFilterType {

  DateTime get start {
    DateTime now = DateTime.now();
    if (this == TimeFilterType.lastSession) {
      return DateTime(now.year, now.month, now.day);
    }
    else
      return now.subtract(Duration(days: 7));
  }

  // all available filter types end with the current time
  DateTime get end => DateTime.now();
}
