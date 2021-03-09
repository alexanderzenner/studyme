import 'package:hive/hive.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/phase/phase.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/task/task.dart';

part 'phase_withdrawal.g.dart';

@JsonSerializable()
@HiveType(typeId: 207)
class WithdrawalPhase extends Phase {
  static const String phaseType = 'withdrawal';

  WithdrawalPhase({String letter}) : super(letter: letter);

  WithdrawalPhase.fromIntervention(
      {String letter, Intervention withdrawnIntervention})
      : super(
            type: phaseType,
            name: 'Without "${withdrawnIntervention.name}"',
            letter: letter);

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    return [];
  }

  factory WithdrawalPhase.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalPhaseFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawalPhaseToJson(this);
}
