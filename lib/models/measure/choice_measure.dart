import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/measure.dart';

import '../schedule.dart';
import 'aggregations.dart';

part 'choice_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class ChoiceMeasure extends Measure {
  static const String measureType = 'choice';

  @JsonKey(ignore: true)
  final IconData icon = Icons.list;

  @HiveField(6)
  List<Choice> choices;

  ChoiceMeasure(
      {String id,
      String name,
      String description,
      List<Choice> choices,
      ValueAggregation aggregation,
      Schedule schedule})
      : this.choices = choices ?? [],
        super(
            id: id,
            type: measureType,
            name: name,
            description: description,
            aggregation: aggregation,
            schedule: schedule);

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

  factory ChoiceMeasure.fromJson(Map<String, dynamic> json) =>
      _$ChoiceMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceMeasureToJson(this);
}
