import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:charts_flutter/flutter.dart' as charts;

part 'choice_measure.g.dart';

@HiveType(typeId: 3)
class ChoiceMeasure extends Measure {
  static const String measureType = 'choice';
  final IconData icon = Icons.list;

  @HiveField(5)
  List<Choice> choices;

  ChoiceMeasure(
      {String id,
      String name,
      String description,
      List<Choice> choices,
      Aggregation aggregation})
      : this.choices = choices ?? [],
        super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation);

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
