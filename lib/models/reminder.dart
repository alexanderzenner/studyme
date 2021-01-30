import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'reminder.g.dart';

@HiveType(typeId: 203)
class Reminder extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<bool> days;
  @HiveField(2)
  DateTime _time;

  Reminder({String id, List<bool> days, DateTime time})
      : this.days = days ?? List.filled(7, true),
        this._time = time ?? DateTime.now(),
        this.id = id ?? Uuid().v4();

  setAll(bool value) {
    this.days = List.filled(7, value);
  }

  TimeOfDay get time {
    return TimeOfDay.fromDateTime(_time);
  }

  set time(TimeOfDay time) {
    final now = new DateTime.now();
    _time = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  clone() {
    return Reminder(days: this.days, time: this._time);
  }
}
