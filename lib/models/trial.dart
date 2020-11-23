import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/measure/measure.dart';

class Trial {
  Intervention a;
  Intervention b;
  List<Measure> measures;

  int phaseDuration;
  List<String> phaseSequence;
  DateTime startDate;

  List<Intervention> get interventionsInOrder {
    return phaseSequence.map((letter) => getInterventionForLetter(letter)).toList();
  }

  Intervention getInterventionForLetter(String letter) {
    if (letter == 'a')
      return a;
    else if (letter == 'b')
      return b;
    else
      return null;
  }

  int _getInterventionIndexForDate(DateTime date) {
    final test = date.differenceInDays(startDate).inDays;
    return test ~/ phaseDuration;
  }

  Intervention getInterventionForDate(DateTime date) {
    final index = _getInterventionIndexForDate(date);
    if (index < 0 || index >= phaseSequence.length) {
      print('Study is over or has not begun.');
      return null;
    }
    final interventionLetter = phaseSequence[index];
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
