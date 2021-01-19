import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';

List<Measure> get defaultMeasures => [
      ChoiceMeasure(name: 'Rate your pain', choices: [
        Choice(value: 'Low'),
        Choice(value: 'Medium'),
        Choice(value: 'High')
      ])
    ];
