import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
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
    KeyboardMeasure(id: (id++).toString(), name: 'Weight', unit: 'kg'),
    KeyboardMeasure(
      id: (id++).toString(),
      name: 'Heart Rate',
      unit: 'bpm',
    ),
    KeyboardMeasure(
        id: (id++).toString(), name: 'Blood Glucose', unit: 'mg/dL'),
    KeyboardMeasure(
      id: (id++).toString(),
      name: 'Blood Oxygen',
      unit: '%',
    ),
    KeyboardMeasure(
        id: (id++).toString(), name: 'Blood Pressure Diastolic', unit: 'mmHg'),
    KeyboardMeasure(
        id: (id++).toString(), name: 'Blood Pressure Systolic', unit: 'mmHg'),
    KeyboardMeasure(
        id: (id++).toString(), name: 'Body Temperature', unit: '°C'),
    KeyboardMeasure(
        id: (id++).toString(), name: 'Body Fat Percentage', unit: '%'),
  ];
}
