import 'package:flutter/cupertino.dart';
import 'package:studyme/models/intervention/abstract_intervention.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:uuid/uuid.dart';

class AppState extends ChangeNotifier {
  String _outcome;
  Trial _trial;
  List<Measure> _measures;
  List<TrialLog> _logs;

  String get outcome => _outcome;
  Trial get trial => _trial;
  List<Measure> get measures => _measures;

  void setOutcome(String outcome) {
    _outcome = outcome;
  }

  void setInterventionA(AbstractIntervention intervention) {
    _trial.a = intervention;
    notifyListeners();
  }

  void setInterventionB(AbstractIntervention intervention) {
    print(intervention.runtimeType);
    _trial.b = intervention;
    notifyListeners();
  }

  AppState() {
    _logs = [];

    // setup trial

    final _interventionA = Intervention()
      ..id = Uuid().v4()
      ..name = 'Take medicine'
      ..description = 'Take your bloody medicine right now';
    final _interventionB = Intervention()
      ..id = Uuid().v4()
      ..name = 'Do sport'
      ..description = '';

    _trial = Trial()
      ..a = _interventionA
      ..b = _interventionB
      ..measures = []
      ..phaseSequence = ['a', 'b', 'b', 'a', 'a', 'b']
      ..phaseDuration = 7
      ..startDate = DateTime.now();

    /*
    final _measure = ScaleMeasure()
      ..id = Uuid().v4()
      ..min = 0
      ..max = 10
      ..name = 'Rate your pain'; */

    final choice1 = Choice()..value = 'Low';
    final choice2 = Choice()..value = 'Medium';
    final choice3 = Choice()..value = 'High';
    final _measure = ChoiceMeasure()
      ..isDefault = true
      ..id = Uuid().v4()
      ..name = 'Rate your pain'
      ..choices = [choice1, choice2, choice3];

    _measures = List.from([_measure]);
  }

  void updateMeasure(int index, Measure measure) {
    _trial.measures[index] = measure;
    notifyListeners();
  }

  void createMeasure(Measure measure) {
    _measures.add(measure);
    notifyListeners();
  }

  void addMeasureToTrial(Measure measure) {
    _trial.measures.add(measure);
    notifyListeners();
  }
}
