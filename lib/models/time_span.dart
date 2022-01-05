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
        ticks: json["ticks"] == null ? null : json["ticks"],
        days: json["days"] == null ? null : json["days"],
        hours: json["hours"] == null ? null : json["hours"],
        milliseconds: json["milliseconds"] == null ? null : json["milliseconds"],
        minutes: json["minutes"] == null ? null : json["minutes"],
        seconds: json["seconds"] == null ? null : json["seconds"],
      );

  Map<String, dynamic> toJson() => {
        "ticks": ticks,
        "days": days,
        "hours": hours,
        "milliseconds": milliseconds,
        "minutes": minutes,
        "seconds": seconds,
      };
}
