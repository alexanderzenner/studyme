import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'schedule.g.dart';

@HiveType(typeId: 204)
class Schedule {
  final year = 2000;
  final month = 1;
  final day = 1;

  @HiveField(0)
  int frequency;
  @HiveField(1)
  List<DateTime> timestamps;

  List<TimeOfDay> get times {
    return timestamps.map((e) => TimeOfDay.fromDateTime(e)).toList();
  }

  Schedule({this.frequency = 1, List<DateTime> timestamps})
      : this.timestamps = timestamps ?? [];

  addTime(TimeOfDay time) {
    // only care about time and hour, but hive needs to save datetime
    final newTimestamp = _generateDateTime(time);
    if (!_containsTime(newTimestamp)) {
      timestamps.add(newTimestamp);
    }
    _sortTimes();
  }

  updateTime(int index, TimeOfDay time) {
    final newTimestamp = _generateDateTime(time);
    if (index < timestamps.length && !_containsTime(newTimestamp)) {
      timestamps[index] = newTimestamp;
      _sortTimes();
    }
  }

  removeTime(int index) {
    timestamps.removeAt(index);
  }

  _sortTimes() {
    timestamps.sort((a, b) => a.compareTo(b));
  }

  _generateDateTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  _containsTime(DateTime newTimestamp) {
    for (var timestamp in timestamps) {
      if (timestamp.compareTo(newTimestamp) == 0) {
        return true;
      }
    }
    return false;
  }

  String get readable {
    if (times.length == 0) {
      return '';
    }

    String _text;
    if (frequency == 1) {
      _text = "Every day";
    } else {
      _text = "Every ${frequency.toString()} days";
    }
    _text += " at ";
    for (var i = 0; i < times.length; i++) {
      _text += "${times[i].readable}";
      if (i < times.length - 1) {
        _text += ", ";
      }
    }

    return _text;
  }

  clone() {
    return Schedule(
        frequency: this.frequency,
        timestamps: List<DateTime>.from(this.timestamps));
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get readable => DefaultMaterialLocalizations()
      .formatTimeOfDay(this, alwaysUse24HourFormat: true);
}
