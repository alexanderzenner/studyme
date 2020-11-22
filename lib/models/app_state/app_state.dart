import 'package:flutter/cupertino.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/intervention/no_intervention.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/trial.dart';

class AppState extends ChangeNotifier {
  String _outcome;
  Trial _trial;

  String get outcome => _outcome;
  Trial get trial => _trial;

  void setOutcome(String outcome) {
    _outcome = outcome;
  }

  void setInterventionAToNoIntervention() {
    this.setInterventionA(NoIntervention());
  }

  void setInterventionA(Intervention intervention) {
    _trial.a = intervention;
  }

  void setInterventionB(Intervention intervention) {
    _trial.b = intervention;
  }

  AppState() {
    _trial = Trial();
    _trial.measures = List();
    _trial.measures.add(ScaleMeasure()..name = 'hi');
  }

  void updateMeasure(int index, Measure measure) {
    _trial.measures[index] = measure;
    notifyListeners();
  }

  void addMeasure(Measure measure) {
    _trial.measures.add(measure);
    notifyListeners();
  }
}
