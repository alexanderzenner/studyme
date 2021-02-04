import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/measure.dart';

part 'scale_measure.g.dart';

@HiveType(typeId: 2)
class ScaleMeasure extends Measure {
  static const String measureType = 'scale';
  final IconData icon = Icons.linear_scale;

  @HiveField(5)
  num min;

  @HiveField(6)
  num max;

  @HiveField(7)
  num initial;

  ScaleMeasure(
      {String id,
      String name,
      String description,
      num min,
      num max,
      Aggregation aggregation})
      : this.min = min ?? 0.0,
        this.max = max ?? 10.0,
        super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation);

  ScaleMeasure.clone(ScaleMeasure measure)
      : min = measure.min,
        max = measure.max,
        initial = measure.initial,
        super.clone(measure);
}
