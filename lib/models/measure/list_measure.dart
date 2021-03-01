import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/measure.dart';

import '../schedule.dart';
import 'aggregations.dart';

part 'list_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class ListMeasure extends Measure {
  static const String measureType = 'list';

  static const IconData icon = Icons.list;

  @HiveField(6)
  List<ListItem> choices;

  String get choicesString => choices.fold(
      '',
      (previousValue, element) =>
          previousValue +
          (previousValue.length > 0 ? ', ' : '') +
          element.value);

  ListMeasure(
      {String id,
      String name,
      String description,
      List<ListItem> choices,
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

  ListMeasure.clone(ListMeasure measure)
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

  factory ListMeasure.fromJson(Map<String, dynamic> json) =>
      _$ListMeasureFromJson(json);
  Map<String, dynamic> toJson() => _$ListMeasureToJson(this);
}
