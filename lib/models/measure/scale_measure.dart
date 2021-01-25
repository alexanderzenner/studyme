import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/measure.dart';

part 'scale_measure.g.dart';

@HiveType(typeId: 2)
class ScaleMeasure extends Measure {
  static const String measureType = 'scale';
  final IconData icon = Icons.linear_scale;

  @HiveField(4)
  double min;

  @HiveField(5)
  double max;

  @HiveField(6)
  double initial;

  ScaleMeasure({id, name, description, min, max})
      : this.min = min != null ? min : 0,
        this.max = max != null ? max : 10,
        super(id: id, type: measureType, name: name, description: description);

  ScaleMeasure.clone(ScaleMeasure measure)
      : min = measure.min,
        max = measure.max,
        initial = measure.initial,
        super.clone(measure);
}
