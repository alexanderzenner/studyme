import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention/intervention.dart';
import 'package:studyme/models/schedule.dart';
import 'package:studyme/models/task/task.dart';

part 'no_intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 102)
class NoIntervention extends Intervention {
  static const String interventionType = 'no_intervention';

  final name = 'Baseline';
  final description = 'TBD';

  NoIntervention({letter}) : super(type: interventionType, letter: letter);

  @override
  final Schedule schedule = null;

  @override
  List<Task> getTasksFor(daysSinceBeginningOfTimeRange) {
    return [];
  }

  NoIntervention.clone(NoIntervention intervention) : super.clone(intervention);

  factory NoIntervention.fromJson(Map<String, dynamic> json) =>
      _$NoInterventionFromJson(json);
  Map<String, dynamic> toJson() => _$NoInterventionToJson(this);
}
