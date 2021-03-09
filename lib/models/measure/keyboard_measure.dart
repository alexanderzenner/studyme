import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/schedule.dart';

import 'aggregations.dart';

part 'keyboard_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class KeyboardMeasure extends Measure {
  static const String measureType = 'keyboard';

  static const IconData icon = Icons.dialpad;

  KeyboardMeasure(
      {String id,
      String name,
      String description,
      String unit,
      ValueAggregation aggregation,
      Schedule schedule})
      : super(
            id: id,
            type: measureType,
            name: name,
            unit: unit,
            description: description,
            aggregation: aggregation,
            schedule: schedule);

  KeyboardMeasure.clone(KeyboardMeasure measure) : super.clone(measure);

  factory KeyboardMeasure.fromJson(Map<String, dynamic> json) =>
      _$KeyboardMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$KeyboardMeasureToJson(this);
}
