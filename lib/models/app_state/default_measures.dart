import 'package:health/health.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';

List<Measure> get defaultMeasures => [
      ChoiceMeasure(id: '1', name: 'Rate your pain', choices: [
        Choice(value: 'Low'),
        Choice(value: 'Medium'),
        Choice(value: 'High')
      ]),
      SyncedMeasure(
          id: '2', name: 'Weight', healthDataType: HealthDataType.WEIGHT),
      SyncedMeasure(
          id: '3',
          name: 'Calories Burned',
          healthDataType: HealthDataType.ACTIVE_ENERGY_BURNED),
      SyncedMeasure(
          id: '4',
          name: 'Heart Rate',
          healthDataType: HealthDataType.HEART_RATE),
      SyncedMeasure(
          id: '5',
          name: 'Blood Glucose',
          healthDataType: HealthDataType.BLOOD_GLUCOSE),
      SyncedMeasure(
          id: '6',
          name: 'Blood Oxygen',
          healthDataType: HealthDataType.BLOOD_OXYGEN),
      SyncedMeasure(
          id: '7',
          name: 'Blood Pressure Diastolic',
          healthDataType: HealthDataType.BLOOD_PRESSURE_DIASTOLIC),
      SyncedMeasure(
          id: '8',
          name: 'Blood Pressure Systolic',
          healthDataType: HealthDataType.BLOOD_PRESSURE_SYSTOLIC),
      SyncedMeasure(
          id: '9',
          name: 'Body Temperature',
          healthDataType: HealthDataType.BODY_TEMPERATURE),
      SyncedMeasure(
          id: '10',
          name: 'Body Fat Percentage',
          healthDataType: HealthDataType.BODY_FAT_PERCENTAGE),
    ];
