import 'package:faya_clinic/utils/date_formatter.dart';
import 'package:faya_clinic/utils/trans_util.dart';

class ClinicDate {
  final int startHour;
  final int startMinutes;
  final int endHour;
  final int endMinutes;

  ClinicDate(this.startHour, this.startMinutes, this.endHour, this.endMinutes);

  String get id => "$startHour$startMinutes$endHour$endMinutes";

  // these two getters only used for display the time, can't be used fo comparing with server time
  String get formattedStartEnd12H => "$startTimeFormatted12H $_startPeriod - $endTimeFormatted12H $_endPeriod";
  String get formattedStartEnd24H => "$startTimeFormatted24H - $endTimeFormatted24H";

  String get startTimeFormatted12H => MyDateFormatter.toStringTimeFromHours(startHour, startMinutes);
  String get endTimeFormatted12H => MyDateFormatter.toStringTimeFromHours(endHour, endMinutes);

  String get startTimeFormatted24H => MyDateFormatter.toStringTime24FromHours(startHour, startMinutes);
  String get endTimeFormatted24H => MyDateFormatter.toStringTime24FromHours(endHour, endMinutes);

  String get _startPeriod =>
      MyDateFormatter.isAmPeriod(startHour, startMinutes) ? TransUtil.trans('label_am') : TransUtil.trans('label_pm');
  String get _endPeriod =>
      MyDateFormatter.isAmPeriod(endHour, endMinutes) ? TransUtil.trans('label_am') : TransUtil.trans('label_pm');
}
