import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/util/health_connector.dart';

import 'aggregations.dart';

part 'automatic_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class AutomaticMeasure extends Measure {
  static const String measureType = 'automatic';

  static const IconData icon = Icons.devices_other;

  @HiveField(7)
  String trackedHealthDataTypeName;

  HealthDataType get trackedHealthDataType => HealthDataType.values
      .firstWhere((t) => t.toString() == this.trackedHealthDataTypeName);

  AutomaticMeasure(
      {String id,
      String name,
      String unit,
      HealthDataType healthDataType,
      String description,
      ValueAggregation aggregation,
      Schedule schedule})
      : trackedHealthDataTypeName = healthDataType.toString(),
        super(
            id: id,
            type: measureType,
            name: name,
            unit: unit,
            description: description,
            aggregation: aggregation,
            schedule: schedule);

  @override
  Future<bool> get canAdd {
    return HealthConnector().requestAuthorization([this.trackedHealthDataType]);
  }

  @override
  bool get canEdit => false;

  TrialLog createLogFrom(HealthDataPoint dataPoint) {
    return TrialLog(this.id, dataPoint.dateTo, dataPoint.value);
  }

  factory AutomaticMeasure.fromJson(Map<String, dynamic> json) =>
      _$AutomaticMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$AutomaticMeasureToJson(this);
}
