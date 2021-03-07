import 'package:health/health.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/automatic_measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';

List<Measure> get defaultMeasures {
  int id = 0;
  return [
    ScaleMeasure(id: (id++).toString(), name: 'Pain', min: 0, max: 10),
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
      healthDataType: HealthDataType.WEIGHT,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Heart Rate',
      healthDataType: HealthDataType.HEART_RATE,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Glucose',
      healthDataType: HealthDataType.BLOOD_GLUCOSE,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Oxygen',
      healthDataType: HealthDataType.BLOOD_OXYGEN,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Pressure Diastolic',
      healthDataType: HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    ),
    AutomaticMeasure(
      id: (id++).toString(),
      name: 'Blood Pressure Systolic',
      healthDataType: HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    ),
    AutomaticMeasure(
        id: (id++).toString(),
        name: 'Body Temperature',
        healthDataType: HealthDataType.BODY_TEMPERATURE),
    AutomaticMeasure(
        id: (id++).toString(),
        name: 'Body Fat Percentage',
        healthDataType: HealthDataType.BODY_FAT_PERCENTAGE),
  ];
}
