import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/measure.dart';

class Trial {
  String outcome;
  Intervention A;
  Intervention B;
  List<Measure> measures;

  int phaseDuration;
  List<int> phaseSequence;
}
