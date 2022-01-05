class ClinicDate {
  final int startHour;
  final int startMinutes;
  final int endHour;
  final int endMinutes;

  ClinicDate(this.startHour, this.startMinutes, this.endHour, this.endMinutes);

  String get id => "$startHour$startMinutes$endHour$endMinutes";
  String get title => "$_startString - $_endString";

  String get _startString => "${startHour.toString().padLeft(2, '0')}:${startMinutes.toString().padLeft(2, '0')}";
  String get _endString => "${endHour.toString().padLeft(2, '0')}:${endMinutes.toString().padLeft(2, '0')}";
}
