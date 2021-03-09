import 'package:hive/hive.dart';
import 'package:studyme/models/phase/phase_withdrawal.dart';
import 'package:studyme/models/task/task.dart';

import 'phase_intervention.dart';

typedef PhaseParser = Phase Function(Map<String, dynamic> data);

abstract class Phase {
  static Map<String, PhaseParser> phaseTypes = {
    InterventionPhase.phaseType: (json) => InterventionPhase.fromJson(json),
    WithdrawalPhase.phaseType: (json) => WithdrawalPhase.fromJson(json),
  };
  @HiveField(0)
  String type;

  @HiveField(1)
  String name;

  @HiveField(2)
  String letter;

  Phase({this.type, this.name, this.letter});

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange);

  Map<String, dynamic> toJson();

  factory Phase.fromJson(Map<String, dynamic> data) =>
      phaseTypes[data["phaseType"]](data);
}
