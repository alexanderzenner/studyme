import 'package:studyme/models/intervention/abstract_intervention.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial_schedule.dart';

class Trial {
  AbstractIntervention a;
  AbstractIntervention b;
  List<Measure> measures;

  TrialSchedule schedule;
  DateTime startDate;

  List<AbstractIntervention> get interventionsInOrder {
    return schedule.phaseSequence
        .map((letter) => getInterventionForLetter(letter))
        .toList();
  }

  AbstractIntervention getInterventionForLetter(String letter) {
    if (letter == 'a')
      return a;
    else if (letter == 'b')
      return b;
    else
      return null;
  }

  int _getInterventionIndexForDate(DateTime date) {
    final test = date.differenceInDays(startDate).inDays;
    return test ~/ schedule.phaseDuration;
  }

  AbstractIntervention getInterventionForDate(DateTime date) {
    final index = _getInterventionIndexForDate(date);
    if (index < 0 || index >= schedule.phaseSequence.length) {
      print('Study is over or has not begun.');
      return null;
    }
    final interventionLetter = schedule.phaseSequence[index];
    return getInterventionForLetter(interventionLetter);
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
