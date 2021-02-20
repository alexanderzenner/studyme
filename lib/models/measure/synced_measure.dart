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

part 'synced_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class SyncedMeasure extends Measure {
  static const String measureType = 'synced';

  @JsonKey(ignore: true)
  final IconData icon = Icons.devices_other;

  @HiveField(6)
  String trackedHealthDataTypeName;

  HealthDataType get trackedHealthDataType => HealthDataType.values
      .firstWhere((t) => t.toString() == this.trackedHealthDataTypeName);

  SyncedMeasure(
      {String id,
      String name,
      HealthDataType healthDataType,
      String description,
      ValueAggregation aggregation,
      Schedule schedule})
      : trackedHealthDataTypeName = healthDataType.toString(),
        super(
            id: id,
            type: measureType,
            name: name,
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

  factory SyncedMeasure.fromJson(Map<String, dynamic> json) =>
      _$SyncedMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$SyncedMeasureToJson(this);
}
