import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/models/schedule.dart';

List<Measure> get defaultMeasures {
  final Schedule defaultSchedule = Schedule();
  defaultSchedule.addTime(TimeOfDay(hour: 9, minute: 0));
  int id = 0;
  return [
    ChoiceMeasure(
        id: (id++).toString(),
        name: 'Pain',
        choices: [
          Choice(value: 'Low'),
          Choice(value: 'Medium'),
          Choice(value: 'High')
        ],
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Weight',
        healthDataType: HealthDataType.WEIGHT,
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Heart Rate',
        healthDataType: HealthDataType.HEART_RATE,
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Glucose',
        healthDataType: HealthDataType.BLOOD_GLUCOSE,
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Oxygen',
        healthDataType: HealthDataType.BLOOD_OXYGEN,
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Pressure Diastolic',
        healthDataType: HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Pressure Systolic',
        healthDataType: HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        schedule: defaultSchedule),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Body Temperature',
        healthDataType: HealthDataType.BODY_TEMPERATURE),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Body Fat Percentage',
        healthDataType: HealthDataType.BODY_FAT_PERCENTAGE),
  ];
}
