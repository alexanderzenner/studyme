import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:uuid/uuid.dart';

import '../schedule.dart';
import '../scheduled_item.dart';
import '../task/task.dart';
import 'aggregations.dart';
import 'choice_measure.dart';
import 'free_measure.dart';

typedef MeasureTaskParser = Measure Function(Map<String, dynamic> data);

abstract class Measure extends ScheduledItem {
  static Map<String, MeasureTaskParser> measureTypes = {
    ChoiceMeasure.measureType: (json) => ChoiceMeasure.fromJson(json),
    FreeMeasure.measureType: (json) => FreeMeasure.fromJson(json),
    ScaleMeasure.measureType: (json) => ScaleMeasure.fromJson(json),
    SyncedMeasure.measureType: (json) => SyncedMeasure.fromJson(json),
  };

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

  @JsonKey(ignore: true)
  IconData icon;

  Measure(
      {this.id,
      this.type,
      this.name,
      this.description,
      ValueAggregation aggregation,
      Schedule schedule}) {
    this.aggregation = aggregation ?? ValueAggregation.Average;
    this.id = id ?? Uuid().v4();
    this.schedule = schedule ?? Schedule();
  }

  Measure.clone(Measure measure)
      : id = Uuid().v4(),
        type = measure.type,
        name = measure.name,
        description = measure.description,
        aggregation = measure.aggregation,
        super.clone(measure);

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

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    List<TimeOfDay> times =
        this.schedule.getTaskTimesFor(daysSinceBeginningOfTimeRange);
    return times.map((time) => MeasureTask(this, time)).toList();
  }

  Map<String, dynamic> toJson();

  factory Measure.fromJson(Map<String, dynamic> data) =>
      measureTypes[data["measureType"]](data);
}
