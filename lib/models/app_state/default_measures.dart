import 'package:health/health.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';

List<Measure> get defaultMeasures => [
      ChoiceMeasure(id: 'one', name: 'Rate your pain', choices: [
        Choice(value: 'Low'),
        Choice(value: 'Medium'),
        Choice(value: 'High')
      ]),
      SyncedMeasure(
          id: 'two', name: 'Weight', healthDataType: HealthDataType.WEIGHT)
    ];
