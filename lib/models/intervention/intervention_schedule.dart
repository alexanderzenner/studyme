import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'intervention_schedule.g.dart';

@HiveType(typeId: 204)
class InterventionSchedule {
  @HiveField(0)
  List<int> frequency;
  @HiveField(1)
  List<DateTime> _times;

  List<TimeOfDay> get times {
    return _times.map((e) => TimeOfDay.fromDateTime(e)).toList();
  }

  InterventionSchedule({this.frequency, times}) : this._times = times ?? [];

  addTime(TimeOfDay time) {
    // only care about time and hour, but hive needs to save datetime
    final now = new DateTime.now();
    _times.add(DateTime(now.year, now.month, now.day, time.hour, time.minute));
    _sortTimes();
  }

  updateTime(int index, TimeOfDay time) {
    final now = new DateTime.now();
    if (index < _times.length) {
      _times[index] =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      _sortTimes();
    }
  }

  removeTime(int index) {
    _times.removeAt(index);
  }

  _sortTimes() {
    _times.sort((a, b) => a.compareTo(b));
  }

  clone() {
    return InterventionSchedule(
        frequency: this.frequency, times: List<DateTime>.from(this._times));
  }
}
