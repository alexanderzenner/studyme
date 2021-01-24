import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/measure.dart';

part 'synced_measure.g.dart';

@HiveType(typeId: 5)
class SyncedMeasure extends Measure {
  static const String measureType = 'synced';
  final IconData icon = Icons.devices_other;

  @HiveField(4)
  String trackedHealthDataTypeName;

  HealthDataType get trackedHealthDataType => HealthDataType.values
      .firstWhere((t) => t.toString() == this.trackedHealthDataTypeName);

  SyncedMeasure({id, name, HealthDataType healthDataType, description})
      : trackedHealthDataTypeName = healthDataType.toString(),
        super(id: id, type: measureType, name: name, description: description);

  @override
  Future<bool> get canAdd {
    return requestAuthorization(HealthFactory());
  }

  Future<bool> requestAuthorization(healthFactory) {
    return healthFactory.requestAuthorization([
      this.trackedHealthDataType,
    ]);
  }

  Future<List<HealthDataPoint>> getValue() async {
    HealthFactory healthFactory = HealthFactory();
    await requestAuthorization(healthFactory);
    final now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day, 0, 0);
    DateTime endDate = DateTime(now.year, now.month, now.day, 23, 59);

    return healthFactory.getHealthDataFromTypes(
        startDate, endDate, [this.trackedHealthDataType]);
  }

  @override
  bool get canEdit => false;
}
