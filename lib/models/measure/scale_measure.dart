import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/measure.dart';

import '../schedule.dart';
import 'aggregations.dart';

part 'scale_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class ScaleMeasure extends Measure {
  static const String measureType = 'scale';

  final IconData icon = Icons.linear_scale;

  @HiveField(6)
  double min;

  @HiveField(7)
  double max;

  @HiveField(8)
  double initial;

  String get scaleString =>
      "min: " + min.toInt().toString() + ", max: " + max.toInt().toString();

  ScaleMeasure(
      {String id,
      String name,
      String description,
      double min,
      double max,
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

  factory ScaleMeasure.fromJson(Map<String, dynamic> json) =>
      _$ScaleMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$ScaleMeasureToJson(this);
}
