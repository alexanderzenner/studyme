import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/measure.dart';

class ChoiceMeasure extends Measure {
  static const String measureType = 'choice';
  final IconData icon = Icons.list;

  List<Choice> choices;

  ChoiceMeasure()
      : choices = [],
        super(measureType);

  ChoiceMeasure.clone(ChoiceMeasure measure)
      : choices = List.of(measure.choices),
        super.clone(measure);
}
