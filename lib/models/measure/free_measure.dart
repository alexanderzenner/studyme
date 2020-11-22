import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';

class FreeMeasure extends Measure {
  static const String measureType = 'free';
  final IconData icon = Icons.dialpad;

  FreeMeasure() : super(measureType);

  FreeMeasure.clone(FreeMeasure measure) : super.clone(measure);
}
