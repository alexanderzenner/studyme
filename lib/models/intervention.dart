import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/mixins/has_schedule.dart';
import 'package:studyme/models/reminder.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:uuid/uuid.dart';

part 'intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 101)
class Intervention with HasSchedule {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @JsonKey(ignore: true)
  @HiveField(2)
  String description;

  @HiveField(3)
  String instructions;

  @HiveField(4)
  Reminder schedule;

  Intervention(
      {id, this.name, this.description, this.instructions, Reminder schedule}) {
    this.id = id ?? Uuid().v4();
    this.schedule = schedule ?? Reminder();
  }

  Intervention.clone(Intervention intervention) {
    this.id = Uuid().v4();
    this.name = intervention.name;
    this.description = intervention.description;
    this.instructions = intervention.instructions;
    this.schedule = intervention.schedule;
  }

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    List<TimeOfDay> times =
        this.schedule.getTaskTimesFor(daysSinceBeginningOfTimeRange);
    return times.map((time) => InterventionTask(this, time)).toList();
  }

  clone() {
    return Intervention.clone(this);
  }

  factory Intervention.fromJson(Map<String, dynamic> json) =>
      _$InterventionFromJson(json);
  Map<String, dynamic> toJson() => _$InterventionToJson(this);
}
