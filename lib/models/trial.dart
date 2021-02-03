import 'package:hive/hive.dart';
import 'package:studyme/models/reminder.dart';
import './measure/measure.dart';
import 'intervention/intervention.dart';
import 'measure/synced_measure.dart';
import 'trial_schedule.dart';

part 'trial.g.dart';

@HiveType(typeId: 200)
class Trial extends HiveObject {
  @HiveField(0)
  Intervention a;

  @HiveField(1)
  Intervention b;

  @HiveField(2)
  List<Measure> measures;

  @HiveField(3)
  TrialSchedule schedule;

  @HiveField(4)
  DateTime startDate;

  @HiveField(5)
  List<Reminder> reminders;

  List<SyncedMeasure> get syncedMeasures {
    return measures.whereType<SyncedMeasure>().toList();
  }

  Trial()
      : this.measures = [],
        this.reminders = [];

  DateTime get endDate {
    return startDate
        .add(Duration(days: this.schedule.duration))
        .subtract(Duration(seconds: 1));
  }

  bool isInStudyTimeframe(DateTime date) {
    return date.isAfter(startDate) && date.isBefore(endDate);
  }

  InterventionWithContext getInterventionForDate(DateTime date) {
    final index = getInterventionIndexForDate(date);
    if (index < 0 || index >= schedule.phaseSequence.length) {
      print('Study is over or has not begun.');
      return null;
    }
    final interventionLetter = schedule.phaseSequence[index];
    return InterventionWithContext(
        isA: interventionLetter == 'a',
        intervention: _getInterventionForLetter(interventionLetter));
  }

  Intervention _getInterventionForLetter(String letter) {
    if (letter == 'a')
      return a;
    else if (letter == 'b')
      return b;
    else
      return null;
  }

  int getInterventionIndexForDate(DateTime date) {
    final test = date.differenceInDays(startDate).inDays;
    return test ~/ schedule.phaseDuration;
  }
}

extension DateOnlyCompare on DateTime {
  // needed for models
  Duration differenceInDays(DateTime other) {
    final currentZero = DateTime(year, month, day);
    final otherZero = DateTime(other.year, other.month, other.day);
    return currentZero.difference(otherZero);
  }
}
