import 'package:faya_clinic/models/clinic_date.dart';

class ClinicDates {
  static List<ClinicDate> standardDates = [
    ClinicDate(10, 0, 10, 30),
    ClinicDate(10, 30, 11, 0),
    ClinicDate(11, 0, 11, 30),
    ClinicDate(11, 30, 12, 0),
    ClinicDate(12, 0, 12, 30),
    ClinicDate(12, 30, 13, 0),
    ClinicDate(13, 0, 13, 30),
    ClinicDate(13, 30, 14, 0),
    ClinicDate(14, 0, 14, 30),
    ClinicDate(14, 30, 15, 0),
    ClinicDate(15, 0, 15, 30),
    ClinicDate(15, 30, 16, 0),
    ClinicDate(16, 0, 16, 30),
    ClinicDate(16, 30, 17, 0),
    ClinicDate(17, 0, 17, 30),
    ClinicDate(17, 30, 18, 0),
    ClinicDate(18, 0, 18, 30),
    ClinicDate(18, 30, 19, 0),
    ClinicDate(19, 0, 19, 30),
    ClinicDate(19, 30, 20, 0),
    ClinicDate(20, 0, 20, 30),
    ClinicDate(20, 30, 21, 0),
    ClinicDate(21, 0, 21, 30),
    ClinicDate(21, 30, 22, 0),
  ];

  static ClinicDate getClinicDateByStartTime(String startTime) {
    print("ClinicDate: getClinicDateByStartTime called on $startTime");
    // the standard time format is as follow HH:MM
    // check if the format correct try to parse the start time
    // then look for the match ClinicDate and return it
    if (startTime == null || startTime.length != 5) return null;
    final startHH = int.parse("${startTime[0]}${startTime[1]}");
    final startMM = int.parse("${startTime[3]}${startTime[4]}");

    print("ClinicDate: getClinicDateByStartTime startHH $startHH");
    print("ClinicDate: getClinicDateByStartTime startMM $startMM");
    return standardDates.firstWhere(
      (element) => element.startHour == startHH && element.startMinutes == startMM,
      orElse: () => null,
    );
  }
}
