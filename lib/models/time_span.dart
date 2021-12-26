import 'dart:convert';

TimeSpan timeSpanFromJson(String str) => TimeSpan.fromJson(json.decode(str));

String timeSpanToJson(TimeSpan data) => json.encode(data.toJson());

class TimeSpan {
  TimeSpan({
    this.ticks,
    this.days,
    this.hours,
    this.milliseconds,
    this.minutes,
    this.seconds,
    this.totalDays,
    this.totalHours,
    this.totalMilliseconds,
    this.totalMinutes,
    this.totalSeconds,
  });

  int ticks;
  int days;
  int hours;
  int milliseconds;
  int minutes;
  int seconds;
  int totalDays;
  int totalHours;
  int totalMilliseconds;
  int totalMinutes;
  int totalSeconds;

  factory TimeSpan.fromJson(Map<String, dynamic> json) => TimeSpan(
      // id: json["id"] == null ? null : json["id"],
      // userId: json["userId"] == null ? null : json["userId"],
      // dateSection: json["dateSection"] == null ? null : DateSection.fromJson(json["dateSection"]),
      // dateService: json["dateService"] == null ? null : DateService.fromJson(json["dateService"]),
      // timeSpan: json["timeSpan"] == null ? null : DateService.fromJson(json["timeSpan"]),
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "userId": userId,
        // "dateSection": dateSection.toJson(),
        // "dateService": dateService.toJson(),
        // "timeSpan": timeSpan.toJson(),
      };
}
