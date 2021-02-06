import 'package:hive/hive.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/models/schedule/trial_schedule.dart';
import './measure/measure.dart';
import 'intervention/intervention.dart';
import 'measure/synced_measure.dart';

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
  TrialPhases phases;

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
        .add(Duration(days: phases.totalDuration))
        .subtract(Duration(seconds: 1));
  }

  int getDayOfStudyFor(DateTime date) {
    return date.differenceInDays(startDate).inDays;
  }

  bool isInStudyTimeframe(DateTime date) {
    return date.isAfter(startDate) && date.isBefore(endDate);
  }

  Intervention getInterventionForDate(DateTime date) {
    final index = getPhaseIndexForDate(date);

    return getInterventionForPhaseIndex(index);
  }

  Intervention getInterventionForPhaseIndex(int index) {
    if (index < 0 || index >= phases.numberOfPhases) {
      print('Study is over or has not begun.');
      return null;
    }
    final interventionLetter = phases.phaseSequence[index];

    if (interventionLetter == 'a')
      return a;
    else if (interventionLetter == 'b')
      return b;
    else
      return null;
  }

  int getPhaseIndexForDate(DateTime date) {
    final test = date.differenceInDays(startDate).inDays;
    return test ~/ phases.phaseDuration;
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
