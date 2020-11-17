import 'package:flutter/cupertino.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/measure.dart';

class Trial extends ChangeNotifier {
  String outcome;
  Intervention a;
  Intervention b;
  List<Measure> measures;

  bool baseline;
  int phaseDuration;
  List<int> phaseSequence;
}
