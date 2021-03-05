import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/task/task.dart';

part 'phase_intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 206)
class InterventionPhase extends Phase {
  static const String phaseType = 'intervention';

  @HiveField(3)
  Intervention intervention;

  InterventionPhase({String letter, Intervention intervention})
      : this.intervention = intervention,
        super(name: intervention.name, letter: letter);

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    return this.intervention.getTasksFor(daysSinceBeginningOfTimeRange);
  }

  factory InterventionPhase.fromJson(Map<String, dynamic> json) =>
      _$InterventionPhaseFromJson(json);
  Map<String, dynamic> toJson() => _$InterventionPhaseToJson(this);
}
