import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/models/scheduled_item.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:uuid/uuid.dart';

import 'no_intervention.dart';

part 'intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 101)
class Intervention extends ScheduledItem {
  static const String interventionType = 'intervention';

  @JsonKey(ignore: true)
  final String typeReadable = 'Intervention';

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

  Intervention(
      {id, type, this.name, this.description, this.letter, Schedule schedule})
      : this.id = id ?? Uuid().v4(),
        this.type = type ?? interventionType,
        super(schedule: schedule);

  Intervention.clone(Intervention intervention)
      : id = Uuid().v4(),
        type = intervention.type,
        name = intervention.name,
        description = intervention.description,
        letter = intervention.letter,
        super.clone(intervention);

  List<Task> getTasksFor(daysSinceBeginningOfTimeRange) {
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
