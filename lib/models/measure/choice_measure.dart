import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChoiceMeasure extends Measure {
  static const String measureType = 'choice';
  final IconData icon = Icons.list;

  List<Choice> choices;

  ChoiceMeasure()
      : choices = [],
        super(measureType);

  ChoiceMeasure.clone(ChoiceMeasure measure)
      : choices = List.of(measure.choices),
        super.clone(measure);

  dynamic get tickProvider => new charts.NumericAxisSpec(
        tickProviderSpec: new charts.StaticNumericTickProviderSpec(
          <charts.TickSpec<num>>[
            ...choices
                .asMap()
                .entries
                .map((e) => TickSpec<num>(e.key, label: e.value.value))
                .toList()
          ],
        ),
      );
}
