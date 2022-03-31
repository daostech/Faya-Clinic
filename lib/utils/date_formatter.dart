import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyDateFormatter {
  static final _dateFormat = new DateFormat('yyyy-MM-dd', 'en_US');
  static final _dateTimeFormat = new DateFormat('yyyy-MM-ddThh:mm:ss', 'en_US');
  static final _timeFormat = new DateFormat('hh:mm', 'en_US'); // 12 hours format
  static final _timeFormat24 = new DateFormat.Hm('en_US'); // 24 hours format

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringDate(DateTime dateTime) {
    if (dateTime == null) return "";
    return _dateFormat.format(dateTime);
  }

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringFormatted(String dateString) {
    if (dateString == null) return "";
    final date = DateTime.parse(dateString);
    return _dateFormat.format(date);
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

  /// returns only the time value from a DateTime instace in the following format HH:mm from as string value
  static String toStringTimeFromHours(int hh, int mm) {
    // the date is ignored we interested only in time here
    // so any value for year, month, day will not make any difference
    // but by convenience we are getting the current time
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hh, mm);
    return _timeFormat.format(dateTime);
  }

  /// returns only the time value from a DateTime instace in the following format HH:mm from as string value
  static String toStringTime24FromHours(int hh, int mm) {
    // the date is ignored we interested only in time here
    // so any value for year, month, day will not make any difference
    // but by convenience we are getting the current tim
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hh, mm);
    return _timeFormat24.format(dateTime);
  }

  /// returns true if the sent DateTime instance is in the am period and false otherwise
  static bool isAmPeriod(int hh, int mm) {
    // the date is ignored we interested only in time here
    // so any value for year, month, day will not make any difference
    // but by convenience we are getting the current time
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hh, mm);
    return TimeOfDay.fromDateTime(dateTime).period == DayPeriod.am ? true : false;
  }
}
