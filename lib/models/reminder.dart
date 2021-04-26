import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/util/time_of_day_extension.dart';

part 'reminder.g.dart';

@JsonSerializable()
@HiveType(typeId: 204)
class Reminder {
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

  Reminder({this.frequency = 1, List<DateTime> timestamps})
      : this.timestamps = timestamps ?? [];

  addTime(TimeOfDay time) {
    // only care about time and hour, but hive needs to save datetime
    final newTimestamp = _generateDateTime(time);
    if (!_containsTime(newTimestamp)) {
      timestamps.add(newTimestamp);
    }
    _sortTimes();
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
      _text = "Daily";
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

  List<TimeOfDay> getTaskTimesFor(int daysSinceBeginningOfTimeRange) {
    bool hasTasksForDate = false;

    if (frequency == 1) {
      hasTasksForDate = true;
    } else if (frequency > 1 &&
        daysSinceBeginningOfTimeRange % frequency == 0) {
      hasTasksForDate = true;
    }

    if (hasTasksForDate) {
      return times;
    } else {
      return [];
    }
  }

  clone() {
    return Reminder(
        frequency: this.frequency,
        timestamps: List<DateTime>.from(this.timestamps));
  }

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
  Map<String, dynamic> toJson() => _$ReminderToJson(this);
}
