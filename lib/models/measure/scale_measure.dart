import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';

class ScaleMeasure extends Measure {
  static const String measureType = 'scale';
  final IconData icon = Icons.linear_scale;
  double min;
  double max;
  double initial;

  ScaleMeasure({id, name, description, this.min, this.max})
      : super(id: id, type: measureType, name: name, description: description);

  ScaleMeasure.clone(ScaleMeasure measure)
      : min = measure.min,
        max = measure.max,
        initial = measure.initial,
        super.clone(measure);
}
