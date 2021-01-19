import 'package:flutter/cupertino.dart';
import 'package:studyme/models/app_state/default_measures.dart';
import 'package:studyme/models/intervention/abstract_intervention.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/log/log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:uuid/uuid.dart';

class AppState extends ChangeNotifier {
  Trial _trial;
  List<Measure> _measures;
  List<TrialLog> _logs;

  Trial get trial => _trial;
  List<Measure> get measures => _measures;
  List<TrialLog> get logs => _logs;

  List<Measure> unaddedMeasures() {
    List<Measure> measures = defaultMeasures;
    measures.removeWhere(
        (i) => _trial.measures.map((x) => x.id).toList().contains(i.id));
    return measures;
  }

  Trial getTrial() {
    return _trial;
  }

  void setInterventionA(AbstractIntervention intervention) {
    _trial.a = intervention;
    notifyListeners();
  }

  void setInterventionB(AbstractIntervention intervention) {
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

    final _trialSchedule = TrialSchedule(
        phaseDuration: 7,
        numberOfCycles: 3,
        phaseOrder: PhaseOrder.alternating);

    _trial = Trial()
      ..a = _interventionA
      ..b = _interventionB
      ..measures = []
      ..schedule = _trialSchedule
      ..startDate = DateTime.now();
  }

  int _getTrialIndexForMeasureId(String id) {
    return _trial.measures.indexWhere((i) => i.id == id);
  }

  void updateMeasure(Measure measure, Measure newMeasure) {
    var index = _getTrialIndexForMeasureId(measure.id);
    if (index >= 0) {
      _trial.measures[index] = newMeasure;
      notifyListeners();
    }
  }

  void addMeasureToTrial(Measure measure) {
    _trial.measures.add(measure);
    notifyListeners();
  }

  void removeMeasureFromTrial(Measure measure) {
    var index = _getTrialIndexForMeasureId(measure.id);
    if (index >= 0) {
      _trial.measures.removeAt(index);
      notifyListeners();
    }
  }

  void updateSchedule(TrialSchedule schedule) {
    _trial.schedule = schedule;
    notifyListeners();
  }

  void addLog(TrialLog log) {
    _logs.add(log);
    notifyListeners();
  }
}
