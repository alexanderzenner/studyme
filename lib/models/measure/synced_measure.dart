import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/measure_log.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/util/health_connector.dart';

part 'synced_measure.g.dart';

@HiveType(typeId: 5)
class SyncedMeasure extends Measure {
  static const String measureType = 'synced';
  final IconData icon = Icons.devices_other;

  @HiveField(5)
  String trackedHealthDataTypeName;

  HealthDataType get trackedHealthDataType => HealthDataType.values
      .firstWhere((t) => t.toString() == this.trackedHealthDataTypeName);

  SyncedMeasure(
      {String id,
      String name,
      HealthDataType healthDataType,
      String description,
      Aggregation aggregation})
      : trackedHealthDataTypeName = healthDataType.toString(),
        super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation);

  @override
  Future<bool> get canAdd {
    return HealthConnector().requestAuthorization([this.trackedHealthDataType]);
  }

  @override
  bool get canEdit => false;

  MeasureLog createLogFrom(HealthDataPoint dataPoint) {
    return MeasureLog(this.id, dataPoint.dateTo, dataPoint.value);
  }
}
