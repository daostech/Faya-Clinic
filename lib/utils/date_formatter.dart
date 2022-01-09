import 'package:easy_localization/easy_localization.dart';

class MyDateFormatter {
  static final _dateFormat = new DateFormat('yyyy-MM-dd', 'en_US');
  static final _dateTimeFormat = new DateFormat('yyyy-MM-ddThh:mm:ss', 'en_US');
  static final _timeFormat = new DateFormat('hh:mm', 'en_US');

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringDate(DateTime dateTime) {
    if (dateTime == null) return "";
    return _dateFormat.format(dateTime);
  }

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringDateTime(DateTime dateTime) {
    if (dateTime == null) return "";
    return _dateTimeFormat.format(dateTime);
  }

  /// returns only the time value from a DateTime instace in the following format hh:mm from as string value
  static String toStringTime(DateTime dateTime) {
    if (dateTime == null) return "";
    return _timeFormat.format(dateTime);
  }

  /// returns the hour number in the 24 hours format from a DateTime instacne
  static int getHourFromDateTime(DateTime dateTime) {
    if (dateTime == null) return -1;
    return dateTime.hour;
  }

  /// returns the hour number in the 24 hours format from a formatted string date
  static int getHourFromString(String dateTime) {
    if (dateTime == null) return -1;
    final dateFromString = DateTime.parse(dateTime);
    return dateFromString.hour;
  }

  /// returns the hour number in the 24 hours format from a 12 hour number
  static int getHourFrom12Format(int hour12Format, bool isAm) {
    if (isAm) {
      // 12 AM in 24 hours format is 0
      if (hour12Format == 12)
        return 0;
      // the range between 1-11 in 24 hours format is the same
      else
        return hour12Format;
    } else {
      if (hour12Format == 12)
        return hour12Format;
      else
        return hour12Format + 12;
    }
  }
}
