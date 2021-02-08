import 'package:hive/hive.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/models/schedule/trial_phases.dart';
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

  List<Reminder> getRemindersForDate(DateTime date) {
    DateTime _cleanDate = DateTime(date.year, date.month, date.day);

    List<Reminder> _reminders = [];

    int daysSinceBeginningOfTrial = _cleanDate.difference(startDate).inDays;
    int daysSinceBeginningOfPhase =
        daysSinceBeginningOfTrial % phases.phaseDuration;

    Intervention _intervention = getInterventionForDate(_cleanDate);

    _reminders.addAll(_intervention.getRemindersFor(daysSinceBeginningOfPhase));
    measures.forEach((measure) {
      _reminders.addAll(measure.getRemindersFor(daysSinceBeginningOfTrial));
    });
    return _reminders;
  }

  List<SyncedMeasure> get syncedMeasures {
    return measures.whereType<SyncedMeasure>().toList();
  }

  Trial() : this.measures = [];

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
