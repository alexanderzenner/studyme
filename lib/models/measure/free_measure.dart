import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/schedule.dart';

import 'aggregations.dart';

part 'free_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class FreeMeasure extends Measure {
  static const String measureType = 'free';

  static const IconData icon = Icons.dialpad;

  FreeMeasure(
      {String id,
      String name,
      String description,
      ValueAggregation aggregation,
      Schedule schedule})
      : super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation,
            schedule: schedule);

  FreeMeasure.clone(FreeMeasure measure) : super.clone(measure);

  factory FreeMeasure.fromJson(Map<String, dynamic> json) =>
      _$FreeMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$FreeMeasureToJson(this);
}
