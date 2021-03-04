import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/mixins/has_schedule.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:uuid/uuid.dart';

import 'no_intervention.dart';

part 'intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 101)
class Intervention with HasSchedule {
  static const String interventionType = 'intervention';

  @HiveField(0)
  String type;

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  @HiveField(4)
  String letter;

  @HiveField(5)
  Schedule schedule;

  Intervention(
      {id, type, this.name, this.description, this.letter, Schedule schedule}) {
    this.type = type ?? interventionType;
    this.id = id ?? Uuid().v4();
    this.schedule = schedule ?? Schedule();
  }

  Intervention.clone(Intervention intervention) {
    this.id = Uuid().v4();
    this.type = intervention.type;
    this.name = intervention.name;
    this.description = intervention.description;
    this.letter = intervention.letter;
    this.schedule = intervention.schedule;
  }

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    List<TimeOfDay> times =
        this.schedule.getTaskTimesFor(daysSinceBeginningOfTimeRange);
    return times.map((time) => InterventionTask(this, time)).toList();
  }

  clone() {
    switch (this.runtimeType) {
      case NoIntervention:
        return NoIntervention.clone(this);
      default:
        return Intervention.clone(this);
    }
  }

  factory Intervention.fromJson(Map<String, dynamic> json) =>
      _$InterventionFromJson(json);
  Map<String, dynamic> toJson() => _$InterventionToJson(this);
}
