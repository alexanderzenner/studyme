import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/measure.dart';

import '../schedule.dart';
import 'aggregations.dart';

part 'scale_measure.g.dart';

@HiveType(typeId: 2)
class ScaleMeasure extends Measure {
  static const String measureType = 'scale';
  final IconData icon = Icons.linear_scale;

  @HiveField(6)
  num min;

  @HiveField(7)
  num max;

  @HiveField(8)
  num initial;

  ScaleMeasure(
      {String id,
      String name,
      String description,
      num min,
      num max,
      ValueAggregation aggregation,
      Schedule schedule})
      : this.min = min ?? 0.0,
        this.max = max ?? 10.0,
        super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation,
            schedule: schedule);

  ScaleMeasure.clone(ScaleMeasure measure)
      : min = measure.min,
        max = measure.max,
        initial = measure.initial,
        super.clone(measure);
}
