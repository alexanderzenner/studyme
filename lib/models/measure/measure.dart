import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:uuid/uuid.dart';

import '../schedule.dart';
import 'aggregations.dart';
import 'choice_measure.dart';
import 'free_measure.dart';

abstract class Measure {
  @HiveField(0)
  String id;
  @HiveField(1)
  String type;
  @HiveField(2)
  String name;
  @HiveField(3)
  String description;
  @HiveField(4)
  ValueAggregation aggregation;
  @HiveField(5)
  Schedule schedule;

  IconData icon;

  Measure(
      {this.id,
      this.type,
      this.name,
      this.description,
      ValueAggregation aggregation,
      Schedule schedule}) {
    this.aggregation = ValueAggregation.Average;
    this.id = id ?? Uuid().v4();
    this.schedule = schedule ?? Schedule();
  }

  Measure.clone(Measure measure)
      : id = Uuid().v4(),
        type = measure.type,
        name = measure.name,
        description = measure.description,
        aggregation = measure.aggregation,
        schedule = measure.schedule.clone();

  clone() {
    switch (this.runtimeType) {
      case FreeMeasure:
        return FreeMeasure.clone(this);
      case ChoiceMeasure:
        return ChoiceMeasure.clone(this);
      case ScaleMeasure:
        return ScaleMeasure.clone(this);
    }
  }

  Future<bool> get canAdd => Future.value(true);

  bool get canEdit => true;

  dynamic get tickProvider => null;
}
