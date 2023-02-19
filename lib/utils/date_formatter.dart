import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faya_clinic/utils/trans_util.dart';
import 'package:flutter/material.dart';

class MyDateFormatter {
  static final _dateFormat = new DateFormat('yyyy-MM-dd', 'en_US');
  static final _monthDayFormat = new DateFormat('MM/dd', 'en_US');
  static final _dateTimeFormat = new DateFormat('yyyy-MM-ddThh:mm:ss', 'en_US');
  static final _dateTimeChatFormat = new DateFormat('dd/MM/yyyy HH:mm:ss', 'en_US');
  static final _timeFormat = new DateFormat('hh:mm', 'en_US'); // 12 hours format
  static final _timeFormat24 = new DateFormat.Hm('en_US'); // 24 hours format

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringDate(DateTime? dateTime) {
    if (dateTime == null) return "";
    return _dateFormat.format(dateTime);
  }

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringFormatted(String? dateString) {
    if (dateString == null) return "";
    final date = DateTime.parse(dateString);
    return _dateFormat.format(date);
  }

  /// returns only the date from a DateTime instace in the following format yyyy-MM-dd as string value
  static String toStringDateTime(DateTime? dateTime) {
    if (dateTime == null) return "";
    return _dateTimeFormat.format(dateTime);
  }

  /// returns the date time as string value in following format dd/MM/yyyy HH:mm:ss
  static String toStringDateTimeChatFormat(DateTime? dateTime) {
    if (dateTime == null) return "";
    return _dateTimeChatFormat.format(dateTime);
  }

  /// returns the date time as string value in following format dd/MM/yyyy HH:mm:ss
  static DateTime? toDateTimeChatFormat(String? dateTimeStr) {
    if (dateTimeStr == null) return null;
    return _dateTimeChatFormat.parse(dateTimeStr);
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

  /// check for the notification date time for the following cases:
  /// 1- if it is today => return the time in the following format hh:mm
  /// 2- else if it yesterday return yesterday label without any date info
  /// 3- otherwise returnt return the date as the following format MM/dd
  static String notificationDate(DateTime? dateTime) {
    if (dateTime == null) return "";
    if (_isToday(dateTime)) {
      return _timeFormat.format(dateTime);
    }
    if (_isYesterday(dateTime)) {
      return TransUtil.trans("label_yesterday");
    }
    return _monthDayFormat.format(dateTime);
  }

  static String notificationDate2(Timestamp timestamp) {
    if (timestamp == null) return "";
    final dateTime = timestamp.toDate();
    if (_isToday(dateTime)) {
      return _timeFormat.format(dateTime);
    }
    if (_isYesterday(dateTime)) {
      return TransUtil.trans("label_yesterday");
    }
    return _monthDayFormat.format(dateTime);
  }

  static bool _isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day;
  }

  static bool _isYesterday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day - 1;
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

  static bool isValidClinicTime(DateTime? dateTime, String standardTime) {
    if (dateTime == null || standardTime == null) return false;
    var hh1;
    var mm1;

    if (standardTime.length == 5) {
      hh1 = int.tryParse(standardTime.substring(0, 2));
      mm1 = int.tryParse(standardTime.substring(3, 5));
    }

    final now = DateTime.now();
    final clinicDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, hh1, mm1);

    return clinicDateTime.isAfter(now);
  }
}
