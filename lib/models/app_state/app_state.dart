import 'package:flutter/cupertino.dart';
import 'package:studyme/models/no_intervention.dart';
import 'package:studyme/models/trial.dart';

class AppState extends ChangeNotifier {
  Trial _trial;

  Trial get trial => _trial;

  void createTrialWithOutcome(String outcome) {
    _trial = Trial()..outcome = outcome;
  }

  void setInterventionAToNoIntervention() {
    _trial.a = NoIntervention();
  }
}
