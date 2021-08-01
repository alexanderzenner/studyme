import 'package:health/health.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/automatic_measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

List<Measure> get defaultMeasures {
  int id = 0;
  return [
    ScaleMeasure(
        id: (id++).toString(),
        name: 'Pain',
        min: 0,
        minLabel: 'No pain',
        max: 10,
        maxLabel: 'Worst possible pain'),
    ListMeasure(id: (id++).toString(), name: 'Mood', items: [
      ListItem(value: '😫'),
      ListItem(value: '🙁'),
      ListItem(value: '😐'),
      ListItem(value: '🙂'),
      ListItem(value: '😃')
    ]),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Weight',
      unit: 'kg',
      healthDataType: HealthDataType.WEIGHT,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Heart Rate',
      unit: 'bpm',
      healthDataType: HealthDataType.HEART_RATE,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Glucose',
      unit: 'mg/dL',
      healthDataType: HealthDataType.BLOOD_GLUCOSE,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Oxygen',
      unit: '%',
      healthDataType: HealthDataType.BLOOD_OXYGEN,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Pressure Diastolic',
      unit: 'mmHg',
      healthDataType: HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Pressure Systolic',
      unit: 'mmHg',
      healthDataType: HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ),
    AutomaticMeasure(
        id: (id++).toString(),
        name: 'Body Temperature',
        unit: '°C',
        healthDataType: HealthDataType.BODY_TEMPERATURE),
    AutomaticMeasure(
        id: (id++).toString(),
        name: 'Body Fat Percentage',
        unit: '%',
        healthDataType: HealthDataType.BODY_FAT_PERCENTAGE),
  ];
}
