import 'package:flutter/cupertino.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/measure/measure.dart';

class Trial extends ChangeNotifier {
  Intervention a;
  Intervention b;
  List<Measure> measures;

  int phaseDuration;
  List<int> phaseSequence;
}
