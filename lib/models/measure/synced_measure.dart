import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/measure.dart';

part 'synced_measure.g.dart';

@HiveType(typeId: 5)
class SyncedMeasure extends Measure {
  static const String measureType = 'synced';
  final IconData icon = Icons.sync;

  @HiveField(4)
  String trackedHealthDataTypeName;

  HealthDataType get trackedHealthDataType => HealthDataType.values.firstWhere(
      (t) => t.toString() == 'HealthDataType.${this.trackedHealthDataType}');

  SyncedMeasure({id, name, HealthDataType healthDataType, description})
      : trackedHealthDataTypeName = healthDataType.toString(),
        super(id: id, type: measureType, name: name, description: description);

  @override
  bool get canEdit => false;
}
